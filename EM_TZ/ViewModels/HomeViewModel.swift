//
//  HomeViewModel.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 23.03.2023.
//

import UIKit

final class HomeViewModel {
    
    private var networkService: NetworkServiceProtocol
    var sections = Dynamic([Section]())
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchProducts() {
        networkService.fetchAllProducts { [weak self] sections in
            guard let self = self else {
                print("networkService.fetchAllProducts error")
                return
            }
            self.sections.value = sections
        }
    }
}
