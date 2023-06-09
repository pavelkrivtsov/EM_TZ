//
//  SignInViewModel.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import Foundation

final class SignInViewModel {
    
    private let coordinator: AuthCoordinatorProtocol
    private var coreDataStore: CoreDataStoreProtocol
    var userStatusText = Dynamic("")
    
    init(coordinator: AuthCoordinatorProtocol,
         coreDataStore: CoreDataStoreProtocol) {
        self.coordinator = coordinator
        self.coreDataStore = coreDataStore
    }
    
    private func isInvalidEmail(_ value: String) -> Bool {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value) {
            return true
        }
        return false
    }
    
    func signInButtonPressed(firstName: String?, lastName: String?, email: String?) {
        
        if let firstName = firstName, !firstName.isEmpty,
           let lastName = lastName,!lastName.isEmpty,
           let email = email, !email.isEmpty {
            
            if isInvalidEmail(email) {
                userStatusText.value = "Invalid email"
            } else {
                if coreDataStore.isUserRegistered(firstName: firstName, lastName: lastName, email: email) {
                    userStatusText.value = "The user already exists"
                } else {
                    coordinator.flowCompletionHeandler?()
                }
            }
        } else {
            userStatusText.value = "Fill in the fields"
        }
    }
    
    func loginButtonPressed() {
        coordinator.goToLoginPage()
    }
}
