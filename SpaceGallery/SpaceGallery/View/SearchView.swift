//
//  FeedView.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/6/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

// FIXME: is it necessary?
protocol SearchViewDelegate {
    func onCancelSearch()
}

class SearchView: UIView {
    
    var delegate: SearchViewDelegate?
    
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
        button.addTarget(self, action: #selector(onCancel), for: .touchUpInside)
        return button
    }()
    
    let galleryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 30
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        galleryCollectionView.register(
            ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        setupView()
        activateRegularLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(searchTextFieldView)
        addSubview(cancelButton)
        addSubview(galleryCollectionView)
    }
    
    private func activateRegularLayout() {
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(
                equalTo: searchTextFieldView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -16),
            cancelButton.widthAnchor.constraint(
                equalToConstant: 60),
            
            searchTextFieldView.topAnchor.constraint(
                equalTo: self.layoutMarginsGuide.topAnchor, constant: 16),
            searchTextFieldView.leadingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 16),
            searchTextFieldView.trailingAnchor.constraint(
                equalTo: cancelButton.leadingAnchor, constant: -8),
            
            galleryCollectionView.topAnchor.constraint(
                equalTo: searchTextFieldView.bottomAnchor, constant: 16),
            galleryCollectionView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),
            galleryCollectionView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor)
            ])
    }
    
    @objc private func onCancel() {
        if let controllerDelegate = delegate {
            controllerDelegate.onCancelSearch()
        }
    }
    
}


extension UIColor {
    static let blueSystem = UIColor(
        red: CGFloat(0.0),
        green: CGFloat(122.0/255.0),
        blue: CGFloat(1.0),
        alpha: 1)
}
