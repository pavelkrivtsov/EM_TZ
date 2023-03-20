//
//  LoginViewModel.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 16.03.2023.
//

import Foundation

final class LoginViewModel {
    
    var coordinator: AppCoordinator
    var coreDataStore: CoreDataStore
    var userStatusText = Dynamic("")
    
    init(coordinator: AppCoordinator,
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
