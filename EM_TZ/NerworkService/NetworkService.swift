//
//  NetworkService.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 18.03.2023.
//

import Foundation

final class NetworkService {
    
    func fetchLatest(onCompletion: @escaping (([LatestElement]) -> Void)) {
        
        let urlString = "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, resp, error in
            DispatchQueue.main.async {
                if error != nil {
                    print(error!)
                }
                
                if let resp = resp as? HTTPURLResponse {
                    print(resp)
                }
                guard let responseData = data else { return }
                print("DATA")
                print(responseData)
                
                do {
                    let apiResponse = try JSONDecoder().decode(Latest.self, from: responseData)
                    let latest = apiResponse.latest
                    onCompletion(latest)
                    print(apiResponse)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
}

