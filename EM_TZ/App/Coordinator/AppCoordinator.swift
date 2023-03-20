//
//  AppCoordinator.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var coreDataStore: CoreDataStore
    
    init(navigationController: UINavigationController,
         coreDataStore: CoreDataStore) {
        self.navigationController = navigationController
        self.coreDataStore = coreDataStore
    }
    
    func start() {
//        showSingInScreen()
        showFirstPage()
    }

    func showSingInScreen() {
        let viewModel = SignInViewModel(coordinator: self, coreDataStore: coreDataStore)
        let vc = SignInViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showLoginScreen() {
        let viewModel = LoginViewModel(coordinator: self, coreDataStore: coreDataStore)
        let vc = LoginViewController(viewModel: viewModel)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showFirstPage() {
        let vc = TabBarViewController()
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: false)
    }
}
