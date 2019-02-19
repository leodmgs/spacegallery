//
//  FeedCell.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/6/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let identifier = "com.leodmgs.spacegallery.FeedCell"
    
    let spaceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .orange
        layer.cornerRadius = 15
        clipsToBounds = true
        
        addSubview(spaceImage)
        addSubview(descriptionLabel)
        
        activateRegularConstraints()
        
    }
    
    private func activateRegularConstraints() {
        NSLayoutConstraint.activate([
            
            spaceImage.topAnchor.constraint(equalTo: self.topAnchor),
            spaceImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            spaceImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            spaceImage.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            
            descriptionLabel.heightAnchor.constraint(equalToConstant: 120),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
            ])
    }
    
}
