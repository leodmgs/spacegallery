//
//  LoginView.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/28/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

protocol LoginViewDelegate {
    
    func validateAccess(login: String, passw: String, defaults: Bool) -> Bool
    
    func resetAccess()
    
    func signUp()
    
}

class LoginView: UIView {
    
    var delegate: LoginViewDelegate?
    
    private let welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.textColor = SGColor.sgWhiteColor
        label.font = UIFont.systemFont(ofSize: 34, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    private let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login or password is not correct!"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(SGColor.sgWhiteColor, for: .normal)
        button.backgroundColor = SGColor.sgGreenColor
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        return button
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
    
    private let switchToDefault: CustomSwitchView = {
        let switchView = CustomSwitchView()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.text = "Use default credentials"
        return switchView
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(
            string: "Reset",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(
                    ofSize: 14,
                    weight: .regular),
                NSAttributedString.Key.foregroundColor : SGColor.sgWhiteColor]),
            for: .normal)
        button.setTitleColor(SGColor.sgWhiteColor, for: .normal)
        return button
    }()
    
    //MARK: Customize a button with these properties.
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(
            string: "Sign Up",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(
                    ofSize: 14,
                    weight: .regular),
                NSAttributedString.Key.foregroundColor : SGColor.sgWhiteColor]),
                                  for: .normal)
        button.setTitleColor(SGColor.sgWhiteColor, for: .normal)
        return button
    }()
    
    private let optionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
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
        backgroundColor = .black
        
        loginButton.addTarget(
            self, action: #selector(onLoginTapped), for: .touchUpInside)
        resetButton.addTarget(
            self, action: #selector(onResetPasswordTapped), for: .touchUpInside)
        signUpButton.addTarget(
            self, action: #selector(onSignUpTapped), for: .touchUpInside)
        
        addSubview(welcomeTitleLabel)
        addSubview(warningLabel)
        addSubview(loginTextField)
        addSubview(passwTextField)
        addSubview(loginButton)
        addSubview(switchToDefault)
        
        optionsStackView.addArrangedSubview(resetButton)
        optionsStackView.addArrangedSubview(signUpButton)
        
        addSubview(optionsStackView)
        
    }
    
    @objc public func onLoginTapped() {
        guard let delegate = delegate else { return }
        if let loginInput = loginTextField.text,
            let passwordInput = passwTextField.text {
            let granted = delegate.validateAccess(
                login: loginInput,
                passw: passwordInput,
                defaults: switchToDefault.option.isOn)
            if !granted {
                warningLabel.isHidden = false
                loginTextField.text = ""
                passwTextField.text = ""
                loginTextField.becomeFirstResponder()
            }
        }
    }
    
    @objc func onResetPasswordTapped() {
        guard let delegate = delegate else { return }
        delegate.resetAccess()
    }
    
    @objc func onSignUpTapped() {
        guard let delegate = delegate else { return }
        delegate.signUp()
    }
    
    private func activateRegularConstraints() {
        NSLayoutConstraint.activate([
            
            //FIXME: invalidate current layout in landscape orientation
            welcomeTitleLabel.topAnchor.constraint(
                equalTo: self.layoutMarginsGuide.topAnchor, constant: 50),
            welcomeTitleLabel.leadingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 40),
            welcomeTitleLabel.trailingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -40),
            welcomeTitleLabel.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            welcomeTitleLabel.heightAnchor.constraint(
                greaterThanOrEqualToConstant: 80),
            
            warningLabel.topAnchor.constraint(
                equalTo: welcomeTitleLabel.bottomAnchor),
            warningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            warningLabel.heightAnchor.constraint(equalToConstant: 14),
            warningLabel.leadingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 40),
            warningLabel.trailingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -40),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            loginTextField.widthAnchor.constraint(equalToConstant: 220),
            loginTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginTextField.topAnchor.constraint(
                equalTo: self.warningLabel.bottomAnchor, constant: 8),
            
            passwTextField.heightAnchor.constraint(equalToConstant: 50),
            passwTextField.widthAnchor.constraint(equalToConstant: 220),
            passwTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwTextField.topAnchor.constraint(
                equalTo: loginTextField.bottomAnchor, constant: 8),
            
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.topAnchor.constraint(
                equalTo: passwTextField.bottomAnchor, constant: 8),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 220),
            
            switchToDefault.topAnchor.constraint(
                equalTo: loginButton.bottomAnchor, constant: 22),
            switchToDefault.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            switchToDefault.leadingAnchor.constraint(
                equalTo: loginButton.leadingAnchor),
            switchToDefault.trailingAnchor.constraint(
                equalTo: loginButton.trailingAnchor),
            switchToDefault.heightAnchor.constraint(equalToConstant: 40),
            
            optionsStackView.topAnchor.constraint(
                equalTo: switchToDefault.bottomAnchor, constant: 8),
            optionsStackView.leadingAnchor.constraint(
                equalTo: switchToDefault.leadingAnchor),
            optionsStackView.trailingAnchor.constraint(
                equalTo: switchToDefault.trailingAnchor),
            optionsStackView.heightAnchor.constraint(equalToConstant: 40)
            
            ])
    }
    
}