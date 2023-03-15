//
//  LoginPageViewController.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    var coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let loginLabel = UILabel()
    var firstNameField = UITextField()
    var passwordField = UITextField()
    var loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
        ])
        loginLabel.text = "Welcome back"
        loginLabel.font = .boldSystemFont(ofSize: 35)
        loginLabel.textAlignment = .center
        
        view.addSubview(firstNameField)
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstNameField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 77),
            firstNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            firstNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            firstNameField.heightAnchor.constraint(equalToConstant: 29)
        ])
        firstNameField.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        firstNameField.placeholder = "First name"
        firstNameField.textAlignment = .center
        
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 35),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            passwordField.heightAnchor.constraint(equalToConstant: 29)
        ])
        passwordField.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        passwordField.placeholder = "Second name"
        passwordField.textAlignment = .center
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 99),
            loginButton.heightAnchor.constraint(equalToConstant: 46),
        ])
        loginButton.layer.backgroundColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1).cgColor
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.layer.cornerRadius = 15
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    @objc
    func loginButtonPressed() {
        coordinator.showFirstPage()
    }
}
