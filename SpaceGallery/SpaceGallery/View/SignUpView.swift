//
//  SignUpView.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 3/2/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpViewDelegate {
    func didCancelSignUp()
    func requestToRegister(user: User)
}

class SignUpView: UIView {
    
    var delegate: SignUpViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign Up"
        label.textColor = SGColor.sgWhiteColor
        label.font = UIFont.systemFont(ofSize: 34, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    private let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "All fields are required"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [
                NSAttributedString.Key.foregroundColor : SGColor.sgWhiteColor,
                NSAttributedString.Key.font : UIFont.systemFont(
                    ofSize: 18,
                    weight: .thin)])
        textField.textColor = SGColor.sgWhiteColor
        textField.textAlignment = .center
        textField.layer.cornerRadius = 25;
        textField.layer.borderWidth = 1
        textField.layer.borderColor = SGColor.sgWhiteColor.cgColor
        textField.backgroundColor = SGColor.sgTranslucentColor
        return textField
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Login",
            attributes: [
                NSAttributedString.Key.foregroundColor : SGColor.sgWhiteColor,
                NSAttributedString.Key.font : UIFont.systemFont(
                    ofSize: 18,
                    weight: .thin)])
        textField.textColor = SGColor.sgWhiteColor
        textField.textAlignment = .center
        textField.layer.cornerRadius = 25;
        textField.layer.borderWidth = 1
        textField.layer.borderColor = SGColor.sgWhiteColor.cgColor
        textField.backgroundColor = SGColor.sgTranslucentColor
        return textField
    }()
    
    private let passwTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [
                NSAttributedString.Key.foregroundColor : SGColor.sgWhiteColor,
                NSAttributedString.Key.font : UIFont.systemFont(
                    ofSize: 18,
                    weight: .thin)])
        textField.textColor = SGColor.sgWhiteColor
        textField.textAlignment = .center
        textField.layer.cornerRadius = 25;
        textField.layer.borderWidth = 1
        textField.layer.borderColor = SGColor.sgWhiteColor.cgColor
        textField.backgroundColor = SGColor.sgTranslucentColor
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.setTitleColor(SGColor.sgWhiteColor, for: .normal)
        button.backgroundColor = SGColor.sgGreenColor
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(
            string: "Cancel",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(
                    ofSize: 14,
                    weight: .regular),
                NSAttributedString.Key.foregroundColor : SGColor.sgWhiteColor]),
                                  for: .normal)
        button.setTitleColor(SGColor.sgWhiteColor, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupView() {
        registerButton.addTarget(
            self, action: #selector(onRegisterTapped), for: .touchUpInside)
        cancelButton.addTarget(
            self, action: #selector(onCancelTapped), for: .touchUpInside)
        
        addSubview(titleLabel)
        addSubview(warningLabel)
        addSubview(nameTextField)
        addSubview(loginTextField)
        addSubview(passwTextField)
        addSubview(registerButton)
        addSubview(cancelButton)
        
        activateRegularConstraints()
    }
    
    @objc func onRegisterTapped() {
        guard let delegate = delegate else { return }
        guard let name = nameTextField.text,
            let login = loginTextField.text,
            let passw = passwTextField.text
            else { return }
        
        if name.count == 0 {
            nameTextField.layer.borderColor = SGColor.sgRedColor.cgColor
            warningLabel.isHidden = false
            return
        }
        nameTextField.layer.borderColor = SGColor.sgWhiteColor.cgColor
        if login.count == 0 {
            loginTextField.layer.borderColor = SGColor.sgRedColor.cgColor
            warningLabel.isHidden = false
            return
        }
        loginTextField.layer.borderColor = SGColor.sgWhiteColor.cgColor
        if passw.count == 0 {
            passwTextField.layer.borderColor = SGColor.sgRedColor.cgColor
            warningLabel.isHidden = false
            return
        }
        passwTextField.layer.borderColor = SGColor.sgWhiteColor.cgColor
        delegate.requestToRegister(user:
            User(name: name, login: login, password: passw))
    }
    
    @objc func onCancelTapped() {
        guard let delegate = delegate else { return }
        delegate.didCancelSignUp()
    }
    
    private func activateRegularConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: self.layoutMarginsGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -40),
            titleLabel.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            titleLabel.heightAnchor.constraint(
                greaterThanOrEqualToConstant: 80),
            
            warningLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor),
            warningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            warningLabel.heightAnchor.constraint(equalToConstant: 14),
            warningLabel.leadingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 40),
            warningLabel.trailingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -40),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.widthAnchor.constraint(equalToConstant: 220),
            nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameTextField.topAnchor.constraint(
                equalTo: self.warningLabel.bottomAnchor, constant: 8),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            loginTextField.widthAnchor.constraint(equalToConstant: 220),
            loginTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginTextField.topAnchor.constraint(
                equalTo: self.nameTextField.bottomAnchor, constant: 8),
            
            passwTextField.heightAnchor.constraint(equalToConstant: 50),
            passwTextField.widthAnchor.constraint(equalToConstant: 220),
            passwTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwTextField.topAnchor.constraint(
                equalTo: loginTextField.bottomAnchor, constant: 8),
            
            registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            registerButton.topAnchor.constraint(
                equalTo: passwTextField.bottomAnchor, constant: 8),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: 220),
            
            cancelButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 8),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
            ])
    }
    
}
