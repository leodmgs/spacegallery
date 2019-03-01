//
//  LoginView.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/28/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Login"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        activateRegularConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(loginTextField)
        addSubview(passwTextField)
        addSubview(loginButton)
    }
    
    private func activateRegularConstraints() {
        NSLayoutConstraint.activate([
            
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            loginTextField.widthAnchor.constraint(equalToConstant: 200),
            loginTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginTextField.topAnchor.constraint(equalTo: self.centerYAnchor),
            
            passwTextField.heightAnchor.constraint(equalToConstant: 40),
            passwTextField.widthAnchor.constraint(equalToConstant: 200),
            passwTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwTextField.topAnchor.constraint(
                equalTo: loginTextField.bottomAnchor, constant: 8),
            
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.topAnchor.constraint(
                equalTo: passwTextField.bottomAnchor, constant: 8),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.widthAnchor.constraint(equalToConstant: 100)
            ])
    }
    
}
