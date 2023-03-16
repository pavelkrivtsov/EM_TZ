//
//  LoginViewModel.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 16.03.2023.
//

import Foundation

class LoginViewModel {
    
    var coordinator: AppCoordinator
    var coreDataStore: CoreDataStore
    
    init(coordinator: AppCoordinator,
         coreDataStore: CoreDataStore) {
        self.coordinator = coordinator
        self.coreDataStore = coreDataStore
    }
    
    func loginButtonPressed(name: String) {
        
        if coreDataStore.isUserRegistered(name: name) {
            coordinator.showFirstPage()
        } else {
            print("!isUserRegistered")
        }
    }
}
