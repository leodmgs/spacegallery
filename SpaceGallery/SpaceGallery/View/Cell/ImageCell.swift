//
//  FeedCell.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/6/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let identifier = "com.leodmgs.SpaceGallery.ImageCell.identifier"
    
    let thumbnail: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupView() {
        addSubview(thumbnail)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnail.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            thumbnail.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),
            thumbnail.heightAnchor.constraint(equalToConstant: 220),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: thumbnail.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor)
            
            ])
    }
    
}
