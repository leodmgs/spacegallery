//
//  LoginViewController.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/28/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activateRegularConstraints()
    }
    
    private func setupView() {
        view.addSubview(loginView)
    }
    
    private func activateRegularConstraints() {
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
}
