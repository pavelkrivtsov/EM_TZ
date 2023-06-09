//
//  LoginViewController.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let loginImage = UIImageView(image: UIImage(named: "WelcomeBack"))
    let userStatusLabel = UILabel()
    var firstNameField = CustomTextField(placeholder: "First name")
    var passwordField = CustomTextField(placeholder: "Password")
    var loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(loginImage)
        loginImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(158.71)
            make.leading.trailing.equalToSuperview().inset(43)
        }
        loginImage.contentMode = .scaleAspectFit
        
        view.addSubview(firstNameField)
        firstNameField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginImage.snp.bottom).offset(95)
            make.leading.trailing.equalToSuperview().inset(43)
        }
        
        view.addSubview(passwordField)
        passwordField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstNameField.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(43)
        }
        passwordField.isSecureTextEntry = true
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(43)
            make.top.equalTo(passwordField.snp.bottom).offset(99)
            make.height.equalTo(46)
        }
        loginButton.layer.backgroundColor = UIColor.buttonColor.cgColor
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .init(name: "Montserrat-Bold", size: 15)
        loginButton.layer.cornerRadius = 15
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapRecognizer)
        
        view.addSubview(userStatusLabel)
        userStatusLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(firstNameField)
            make.bottom.equalTo(firstNameField.snp.top)
            make.top.equalTo(loginImage.snp.bottom)
        }
        userStatusLabel.font =  .init(name: "Montserrat-Regular", size: 10)
        userStatusLabel.textAlignment = .center
        userStatusLabel.textColor = .red
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.userStatusText.bind { [weak self] text in
            self?.userStatusLabel.text = text
        }
    }
    
    @objc
    func handleTapGesture() {
        firstNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @objc
    func loginButtonPressed() {
        if let firstName = firstNameField.text, !firstName.isEmpty {
            viewModel.loginButtonPressed(name: firstName)
        }
    }
}
