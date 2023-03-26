//
//  LoginViewModel.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 16.03.2023.
//

import Foundation

final class LoginViewModel {
    
    private let coordinator: AppCoordinatorProtocol
    private var coreDataStore: CoreDataStore
    var userStatusText = Dynamic("")
    
    init(coordinator: AppCoordinatorProtocol,
         coreDataStore: CoreDataStore) {
        self.coordinator = coordinator
        self.coreDataStore = coreDataStore
    }
    
    func loginButtonPressed(name: String) {
        if coreDataStore.isUserRegistered(name: name) {
            coordinator.showFirstPage()
        } else {
            userStatusText.value = "There is no such user"
        }
    }
}
