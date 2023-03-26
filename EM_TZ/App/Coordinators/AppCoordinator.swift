//
//  AppCoordinator.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit

protocol AppCoordinatorProtocol {
    func goToAuth(coreDataStore: CoreDataStoreProtocol)
    func goFirstPage()
    var flowCompletionHeandler: CoordinatorHeandler? { get set }
}

final class AppCoordinator: Coordinator {
    
    let coreDataStore = CoreDataStore()
    var navigationController: UINavigationController
    var flowCompletionHeandler: CoordinatorHeandler?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToAuth(coreDataStore: coreDataStore)
    }
}

extension AppCoordinator: AppCoordinatorProtocol {

    func goToAuth(coreDataStore: CoreDataStoreProtocol) {
        let authCoordinator = AuthCoordinator(navigationController: navigationController, coreDataStore: coreDataStore)
        authCoordinator.flowCompletionHeandler = { [weak self] in
            guard let self = self else { return }
            self.goFirstPage()
        }
        authCoordinator.start()
    }
    
    func goFirstPage() {
        let vc = TabBarViewController(coordinator: self)
        vc.coordinator.flowCompletionHeandler = { [weak self] in
            guard let self = self else { return }
            self.goToAuth(coreDataStore: self.coreDataStore)
        }
        navigationController.setViewControllers([vc], animated: false)
    }
}
