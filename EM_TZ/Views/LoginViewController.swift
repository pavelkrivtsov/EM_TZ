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
    let userStatusLabel = UILabel()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let loginImage = UIImageView(image: UIImage(named: "WelcomeBack"))
    var firstNameField = UITextField()
    var passwordField = UITextField()
    var loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(loginImage)
        loginImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(125)
        }
        
        view.addSubview(firstNameField)
        firstNameField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginImage.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(43)
            make.height.equalTo(29)
        }
        firstNameField.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        firstNameField.placeholder = "First name"
        firstNameField.textAlignment = .center
        
        view.addSubview(passwordField)
        passwordField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstNameField.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(43)
            make.height.equalTo(29)
        }
        passwordField.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        passwordField.placeholder = "Second name"
        passwordField.textAlignment = .center
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(43)
            make.top.equalTo(passwordField.snp.bottom).offset(99)
            make.height.equalTo(46)
        }
        loginButton.layer.backgroundColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1).cgColor
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
