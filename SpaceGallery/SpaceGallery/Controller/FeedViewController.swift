//
//  FeedViewController.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/6/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let feedView: FeedView = {
        let view = FeedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        feedView.delegate = self
        feedView.galleryCollectionView.delegate = self
        feedView.galleryCollectionView.dataSource = self
        setupView()
    }
    
    private func setupView() {
        view.addSubview(feedView)
        NSLayoutConstraint.activate([
            feedView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            feedView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
}

extension FeedViewController: FeedViewDelegate {

    func onCancelSearch() {
        print("cancel in controller")
    }

}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        return feedCell
    }
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // FIXME: use a class of constants to get the right size or turn
        // the height reference dinamically.
        
        // 'screenWidth' represents the width of the screen minus 10%
        let screenWidth = UIScreen.main.bounds.width - ((UIScreen.main.bounds.width * 10.0) / 100.0)
        
        return CGSize(width: screenWidth, height: 350.0)
    }
    
}

