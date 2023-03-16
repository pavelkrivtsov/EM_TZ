//
//  SignInPageViewController.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    var viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let signInLabel = UILabel()
    var firstNameField = UITextField()
    var lastNameField = UITextField()
    var emailField = UITextField()
    var signInButton = UIButton()
    var haveAnAccountlabel = UILabel()
    var loginButton = UIButton()
    
    private lazy var alert: UIAlertController = {
        var alert = UIAlertController(title: "Ошибка",
                                      message: "Заполните поля для регистрации",
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(signInLabel)
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
        ])
        signInLabel.text = "Sign in"
        signInLabel.font = .boldSystemFont(ofSize: 35)
        signInLabel.textAlignment = .center
        
        view.addSubview(firstNameField)
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstNameField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 77),
            firstNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            firstNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            firstNameField.heightAnchor.constraint(equalToConstant: 29)
        ])
        firstNameField.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        firstNameField.placeholder = "First name"
        firstNameField.textAlignment = .center
        
        view.addSubview(lastNameField)
        lastNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 35),
            lastNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            lastNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            lastNameField.heightAnchor.constraint(equalToConstant: 29)
        ])
        lastNameField.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        lastNameField.placeholder = "Second name"
        lastNameField.textAlignment = .center
        
        view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 35),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            emailField.heightAnchor.constraint(equalToConstant: 29)
        ])
        emailField.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        emailField.placeholder = "Email"
        emailField.textAlignment = .center
        
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 35),
            signInButton.heightAnchor.constraint(equalToConstant: 46),
        ])
        signInButton.layer.backgroundColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1).cgColor
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.layer.cornerRadius = 15
        
        view.addSubview(haveAnAccountlabel)
        haveAnAccountlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            haveAnAccountlabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 18),
            haveAnAccountlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
        ])
        haveAnAccountlabel.textColor = UIColor(red: 0.502, green: 0.502, blue: 0.502, alpha: 1)
        haveAnAccountlabel.font = .systemFont(ofSize: 15)
        haveAnAccountlabel.text = "Already have an account?"
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 18),
            loginButton.leadingAnchor.constraint(equalTo: haveAnAccountlabel.trailingAnchor, constant: 9),
            loginButton.heightAnchor.constraint(equalTo: haveAnAccountlabel.heightAnchor)
        ])
        loginButton.setTitle("Log in", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 15)
        loginButton.setTitleColor(UIColor(red: 0.145, green: 0.31, blue: 0.902, alpha: 1), for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    func handleTapGesture() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
    }
    
    @objc
    func signInButtonPressed() {
        if let firstName = firstNameField.text, !firstName.isEmpty,
           let lastName = lastNameField.text, !lastName.isEmpty,
           let email = emailField.text, !email.isEmpty {
            viewModel.signInButtonPressed(firstname: firstName, lastName: lastName, email: email)
        } else {
            present(alert, animated: true)
        }
    }
    
    @objc
    func loginButtonPressed() {
        viewModel.loginButtonPressed()
    }
}

