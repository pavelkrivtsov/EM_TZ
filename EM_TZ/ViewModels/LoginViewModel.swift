//
//  LoginViewModel.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 16.03.2023.
//

import Foundation

final class LoginViewModel {
    
    private var coordinator: AuthCoordinatorProtocol
    private var coreDataStore: CoreDataStoreProtocol
    var userStatusText = Dynamic("")
    
    init(coordinator: AuthCoordinatorProtocol,
         coreDataStore: CoreDataStoreProtocol) {
        self.coordinator = coordinator
        self.coreDataStore = coreDataStore
    }
    
    func loginButtonPressed(name: String) {
        if coreDataStore.isUserRegistered(name: name) {
            coordinator.flowCompletionHeandler?()
        } else {
            userStatusText.value = "There is no such user"
        }
    }
}
