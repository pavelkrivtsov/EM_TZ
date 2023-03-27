//
//  HomeAssembly.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 27.03.2023.
//

import UIKit

class HomeAssembly {
    
    static func assemble(networkService: NetworkServiceProtocol) -> UIViewController {
        let viewModel = HomeViewModel(networkService: networkService)
        let view = HomeViewController(viewModel: viewModel)
        return view
    }
}
