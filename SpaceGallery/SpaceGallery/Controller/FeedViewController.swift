//
//  FeedViewController.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/6/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let searchTextFieldView: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Space Gallery"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        return textField
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.blueSystem, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activateRegularLayout()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(searchTextFieldView)
        view.addSubview(cancelButton)
    }
    
    private func activateRegularLayout() {
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: searchTextFieldView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
            cancelButton.widthAnchor.constraint(equalToConstant: 60),
            searchTextFieldView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            searchTextFieldView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
            searchTextFieldView.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -8)
            ])
    }
    
}

extension UIColor {
    static let blueSystem = UIColor(red: CGFloat(0.0), green: CGFloat(122.0/255.0), blue: CGFloat(1.0), alpha: 1)
}
