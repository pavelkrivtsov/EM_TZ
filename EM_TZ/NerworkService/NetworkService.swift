//
//  NetworkService.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 18.03.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchAllProducts(onCompletion: @escaping([Section]) -> Void)
}

final class NetworkService {
    
    enum NetworkResult<Error> {
        case success
        case failure(Error)
    }

    enum NetworkResponse: String, Error {
        case authenticationError = "Authentication error"
        case badRequest = "Bad request"
        case outdated = "Outdated"
        case failed = "Failed"
        case noData = "No data"
        case unableToDecode = "Unable to decode"
    }
    
    enum URLStrings: String {
        case latest = "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
        case flashSale = "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResult<NetworkResponse> {
        switch response.statusCode {
        case 200...299 : return .success
        case 401...500 : return .failure(NetworkResponse.authenticationError)
        case 501...599 : return .failure(NetworkResponse.badRequest)
        case 600 : return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
    
    private func taskResume<T: Decodable>(from urlString: URLStrings,
                                          type: T.Type,
                                          onCompletion: @escaping(Result<T, NetworkResponse>) -> Void) {
        
        guard let url = URL(string: urlString.rawValue) else {
            onCompletion(.failure(.badRequest))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            guard let `self` = self else { return }
            if error != nil {
                onCompletion(.failure(NetworkResponse.failed))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        onCompletion(.failure(NetworkResponse.noData))
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(type, from: responseData)
                        onCompletion(.success(apiResponse))
                    } catch {
                        onCompletion(.failure(NetworkResponse.unableToDecode))
                    }
                    
                case .failure(let failureError):
                    onCompletion(.failure(failureError))
                }
            }
        }
        task.resume()
    }
    
    private func fetchLatest(onCompletion: @escaping(Result<[LatestElement], NetworkResponse>) -> Void) {

        taskResume(from: .latest, type: Latest.self) { result in
            switch result {
            case .success(let latest):
                let items = latest.latest
                onCompletion(.success(items))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    private func fetchFlashSale(onCompletion: @escaping(Result<[FlashSaleElement], NetworkResponse>) -> Void) {
        
        taskResume(from: .flashSale, type: FlashSale.self) { result in
            switch result {
            case .success(let flashSale):
                let items = flashSale.flashSale
                onCompletion(.success(items))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
}

extension NetworkService: NetworkServiceProtocol {
    
    func fetchAllProducts(onCompletion: @escaping([Section]) -> Void) {
        
        let group = DispatchGroup()
        var sections = [Section]()
        
        group.enter()
        fetchLatest { result in
            switch result {
            case .success(let latestArray):
                var items = [ProductsElement]()
                for item in latestArray {
                    let product = ProductsElement(category: item.category,
                                                  name: item.name,
                                                  price: Float(item.price),
                                                  discount: nil,
                                                  imageURL: item.imageURL)
                    items.append(product)
                }
                sections.append(Section(sectionHeaderName: "Latest", items: items))
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        fetchFlashSale { result in
            switch result {
            case .success(let latestArray):
                var items = [ProductsElement]()
                for item in latestArray {
                    let product = ProductsElement(category: item.category,
                                                  name: item.name,
                                                  price: Float(item.price),
                                                  discount: item.discount,
                                                  imageURL: item.imageURL)
                    items.append(product)
                }
                sections.append(Section(sectionHeaderName: "Flash Sale", items: items))
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            group.leave()
        }

        group.notify(queue: .main) {
            onCompletion(sections)
        }
    }
}
