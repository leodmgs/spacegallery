//
//  SignUpViewController.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 3/2/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    private let signUpView: SignUpView = {
        let view = SignUpView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.delegate = self
        setupView()
        activateRegularConstraints()
    }
    
    private func setupView() {
        view.addSubview(signUpView)
    }
    
    private func activateRegularConstraints() {
        NSLayoutConstraint.activate([
            signUpView.topAnchor.constraint(
                equalTo: view.layoutMarginsGuide.topAnchor),
            signUpView.leadingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.leadingAnchor),
            signUpView.trailingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.trailingAnchor),
            signUpView.bottomAnchor.constraint(
                equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    private func redirectToLoginView() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(
            name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let loginViewController = LoginViewController()
        present(loginViewController, animated: false, completion: nil)
    }
    
}

extension SignUpViewController: SignUpViewDelegate {
    
    func didCancelSignUp() {
        redirectToLoginView()
    }
    
    func requestToRegister(user: User) {
        UserDefaults.standard.set(user.name, forKey: "nameUser")
        UserDefaults.standard.set(user.login, forKey: "loginUser")
        UserDefaults.standard.set(user.password, forKey: "passwUser")
        redirectToLoginView()
    }
    
}
