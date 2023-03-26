//
//  AuthCoordinator.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 26.03.2023.
//

import UIKit

protocol AuthCoordinatorProtocol {
    func goToRegisterPage()
    func goToLoginPage()
    var flowCompletionHeandler: CoordinatorHeandler? { get set }
}

class AuthCoordinator: Coordinator {
        
    var navigationController: UINavigationController
    var coreDataStore: CoreDataStoreProtocol
    var flowCompletionHeandler: CoordinatorHeandler?
    
    init(navigationController : UINavigationController, coreDataStore: CoreDataStoreProtocol) {
        self.navigationController = navigationController
        self.coreDataStore = coreDataStore
    }
    
    func start() {
        goToRegisterPage()
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    
    func goToRegisterPage() {
        let viewModel = SignInViewModel(coordinator: self, coreDataStore: coreDataStore)
        let vc = SignInViewController(viewModel: viewModel)
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func goToLoginPage() {
        let viewModel = LoginViewModel(coordinator: self, coreDataStore: coreDataStore)
        let vc = LoginViewController(viewModel: viewModel)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: false)
    }
}
