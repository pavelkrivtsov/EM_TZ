//
//  SignInPageViewController.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 15.03.2023.
//

import UIKit
import SnapKit

final class SignInViewController: UIViewController {
    
    var viewModel: SignInViewModel
    
    let signInImage = UIImageView(image: UIImage(named: "SignIn"))
    let userStatusLabel = UILabel()
    let firstNameField = UITextField()
    let lastNameField = UITextField()
    let emailField = UITextField()
    let signInButton = UIButton()
    let haveAnAccountlabel = UILabel()
    let loginButton = UIButton()
    

    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(signInImage)
        signInImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(125)
        }
        
        view.addSubview(firstNameField)
        firstNameField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInImage.snp.bottom).offset(77)
            make.leading.trailing.equalToSuperview().inset(43)
            make.height.equalTo(29)
        }
        firstNameField.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        firstNameField.placeholder = "First name"
        firstNameField.font = .init(name: "Montserrat-Medium", size: 10)
        firstNameField.textAlignment = .center
        
        view.addSubview(lastNameField)
        lastNameField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstNameField.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(43)
            make.height.equalTo(29)
        }
        lastNameField.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        lastNameField.placeholder = "Second name"
        lastNameField.font = .init(name: "Montserrat-Medium", size: 10)
        lastNameField.textAlignment = .center
        
        view.addSubview(emailField)
        emailField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lastNameField.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(43)
            make.height.equalTo(29)
        }
        emailField.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        emailField.placeholder = "Email"
        emailField.font = .init(name: "Montserrat-Medium", size: 10)
        emailField.textAlignment = .center
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailField.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(43)
            make.height.equalTo(46)
        }
        signInButton.layer.backgroundColor = UIColor(red: 0.306, green: 0.333, blue: 0.843, alpha: 1).cgColor
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.titleLabel?.font = .init(name: "Montserrat-Bold", size: 15)
        signInButton.layer.cornerRadius = 15
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        view.addSubview(haveAnAccountlabel)
        haveAnAccountlabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(9)
            make.leading.equalTo(signInButton.snp.leading)
        }
        haveAnAccountlabel.textColor = UIColor(red: 0.502, green: 0.502, blue: 0.502, alpha: 1)
        haveAnAccountlabel.font = .init(name: "Montserrat-Regular", size: 10)
        haveAnAccountlabel.text = "Already have an account?"

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.leading.equalTo(haveAnAccountlabel.snp.trailing).offset(9)
            make.height.top.equalTo(haveAnAccountlabel)
        }
        loginButton.setTitle("Log in", for: .normal)
        loginButton.titleLabel?.font = .init(name: "Montserrat-Regular", size: 10)
        loginButton.setTitleColor(UIColor(red: 0.145, green: 0.31, blue: 0.902, alpha: 1), for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapRecognizer)
        
        view.addSubview(userStatusLabel)
        userStatusLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(firstNameField)
            make.bottom.equalTo(firstNameField.snp.top)
            make.top.equalTo(signInImage.snp.bottom)
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
    private func handleTapGesture() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
    }
    
    @objc
    private func signInButtonPressed() {
        viewModel.signInButtonPressed(firstName: firstNameField.text,
                                      lastName: lastNameField.text,
                                      email: emailField.text)
    }
    
    @objc
    private func loginButtonPressed() {
        viewModel.loginButtonPressed()
    }
}

