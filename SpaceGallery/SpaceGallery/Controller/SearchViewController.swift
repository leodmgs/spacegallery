//
//  SearchViewController.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/18/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var queryNetworkService: QueryService = {
        let queryService = QueryService()
        return queryService
    }()
    
    private let galleryDatasource: ImageGalleryDatasource = {
        return ImageGalleryDatasource.shared
    }()
    
    private let searchView: SearchView = {
        let searchView = SearchView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        return searchView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        if let navBar = navigationController {
            navBar.navigationBar.isTranslucent = false
            navBar.navigationBar.barTintColor = .white
            navBar.navigationBar.topItem?.title = "Space Gallery"
        }
        
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
        }
        searchView.delegate = self
        searchView.galleryCollectionView.delegate = self
        searchView.galleryCollectionView.dataSource = self
        searchView.searchTextFieldView.delegate = self
        view.addSubview(searchView)
        activateRegularConstraintsForView()
    }
    
    private func search(query: String) {
        queryNetworkService.searchImages(query: query, completion: {
            imagesCollection in
            if imagesCollection.count == 0 {
                self.searchView.isSearching(
                    state: false,
                    hasResult: false,
                    msg: "No Results!")
                return
            }
            self.galleryDatasource.add(dataCollection: imagesCollection)
            DispatchQueue.main.async {
                // FIXME: don't wait for datasource to load all the contents
                // from the Internet. A minimum set of data should be loaded
                // while the service keep fetching the data.
                self.searchView.galleryCollectionView.reloadData()
                self.searchView.isSearching(state: false, hasResult: true)
            }
        })
    }
    
    private func activateRegularConstraintsForView() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
}


extension SearchViewController: SearchViewDelegate {
    
    func onCancelSearch() {
        searchView.searchTextFieldView.resignFirstResponder()
    }
    
}


extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchText = textField.text {
            let query = searchText.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed)!
            if query.count > 1 {
                self.searchView.isSearching(state: true)
                search(query: query)
            }
        }
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}


// Extension to conform with UICollectionView protocols
extension SearchViewController:
        UICollectionViewDelegate,
        UICollectionViewDataSource,
        UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        if let datasource = galleryDatasource.datasource {
            return datasource.count
        }
        // MARK: display a message indicating that the search doesn't return
        // any result.
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCell.identifier, for: indexPath)
            as! ImageCell
        let imageMetadata = galleryDatasource.index(at: indexPath.item)
        if let imeta = imageMetadata {
            imageCell.thumbnail.fetchImage(imeta.url!)
            let title = imeta.title
            let desc = imeta.description
            let attributedText =
                attributedImageDescription(title: title, desc: desc)
            imageCell.descriptionLabel.attributedText = attributedText
        }
        return imageCell
    }
    
    private func attributedImageDescription(
        title: String, desc: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            string: title,
            attributes: [.font : UIFont.boldSystemFont(ofSize: 18)])
        let descBreakLine = "\n\(desc)"
        attributedString.append(NSAttributedString(
            string: descBreakLine,
            attributes: [.font : UIFont.systemFont(ofSize: 14)]))
        return attributedString
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // FIXME: use a class of constants to get the right size or turn
        // the height reference dinamically.
        let screenWidth = UIScreen.main.bounds.width
        // 'screenWidth' represents the width of the screen minus 10%
        let cellWidth = screenWidth - ((screenWidth * 20.0) / 100.0)
        return CGSize(width: cellWidth, height: 300.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}
