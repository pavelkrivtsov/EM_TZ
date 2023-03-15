//
//  AppCoordinator.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSingInScreen()
    }

    func showSingInScreen() {
        let vc = SignInViewController(coordinator:  self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showLoginScreen() {
        let vc = LoginPageViewController(coordinator:  self)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showFirstPage() {
        let vc = TabBarViewController()
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: false)
    }
}
