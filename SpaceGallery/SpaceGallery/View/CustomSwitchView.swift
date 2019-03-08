//
//  CustomSwitchView.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 3/2/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation
import UIKit

class CustomSwitchView: UIView {
    
    let option: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.isOn = false
        return switchView
    }()
    
    private let switchText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var text: String? {
        didSet {
            guard let text = text else { return }
            DispatchQueue.main.async {
                self.switchText.attributedText = self.attributedText(text: text)
            }
        }
    }
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupView() {
        stackView.addArrangedSubview(option)
        stackView.addArrangedSubview(switchText)
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            option.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            switchText.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    
    private func attributedText(text: String) -> NSAttributedString {
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(
                    ofSize: 14,
                    weight: .regular),
                NSAttributedString.Key.foregroundColor : SGColor.sgWhiteColor])
        return attributedText
    }
    
}
