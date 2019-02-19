//
//  CustomImageView.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/15/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit



class CustomImageView: UIImageView {
    
    private var imageUrl: URL?
    private let imageCache = NSCache<NSString, UIImage>()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    func fetchImage(_ url: URL) {
        imageUrl = url
        
        // Check if the image already exists in cache. If so, set it up and
        // return. Otherwise, URLSession will be used to fetch the image and
        // cache it.
        if let imageCached =
            imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                self.image = imageCached
            }
            return
        }
        
        addSubview(activityIndicator)
        setupRegularSubviewConstraints()
        
        self.image = nil
        activityIndicator.startAnimating()
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let httpResp = response as? HTTPURLResponse,
                (200...299).contains(httpResp.statusCode) else {
                    print(response.debugDescription)
                    return
            }
            if let mimeType = httpResp.mimeType, mimeType == "image/jpeg",
                    let data = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    if let imageToCache = imageToCache {
                        self.imageCache.setObject(
                            imageToCache,
                            forKey: url.absoluteString as NSString)
                    }
                    if self.imageUrl == url {
                        self.image = imageToCache
                    }
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        task.resume()
    }
    
    private func setupRegularSubviewConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(
                equalTo: self.centerYAnchor)
            ])
    }
    
}
