//
//  LoadAsyncImageController.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/8/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

class LoadAsyncImageController: UIViewController {
    
    // FIXME: this is temporary! It will be moved to the Model group.
    private let datasource: [IndexPath:String] = [
        IndexPath(item: 0, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number1.jpg",
        IndexPath(item: 1, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number2.jpg",
        IndexPath(item: 2, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number3.jpg",
        IndexPath(item: 3, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number4.jpg",
        IndexPath(item: 4, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number5.jpg",
        IndexPath(item: 5, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number6.jpg",
        IndexPath(item: 6, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number7.jpg",
        IndexPath(item: 7, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number8.jpg",
        IndexPath(item: 8, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number9.jpg",
        IndexPath(item: 9, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number10.jpg",
        IndexPath(item: 10, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number11.jpg",
        IndexPath(item: 11, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number12.jpg",
        IndexPath(item: 12, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number13.jpg",
        IndexPath(item: 13, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number14.jpg",
        IndexPath(item: 14, section: 0):
        "https://www.kidsmathgamesonline.com/images/pictures/numbers600/number15.jpg"
        ]
    
    /*
        This variable list cannot be accessed directly, so it is private.
        To ensure that the data will not corrupted (thread safe), it must
        be retrieved by a get request for the variable 'planets'.
    */
    private var unsafePlanets: [String] = {
        return ["Mercury", "Venus", "Earth", "Mars",
                "Jupiter", "Saturn", "Uranus", "Neptune"]
    }()
    
    /*
        Once fetching this variable, a concurrent queue will make a copy
        of all data and then return it. In this way, this approach ensure
        the thread safe for the data in 'unsafePlanets'.
     */
    var planets: [String] {
        var planetsCopy: [String] = []
        concurrentQueue.sync {
            planetsCopy.append(contentsOf: self.unsafePlanets)
        }
        return planetsCopy
    }
    
    // Queue to perform critical tasks that needs to be executed concurrently.
    private let concurrentQueue: DispatchQueue = {
        return DispatchQueue(
            label: "com.leodmgs.SpaceGallery.concurrentQueue",
            attributes: .concurrent)
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.waitsForConnectivity = true
        return URLSession(configuration: sessionConfig,
                          delegate: self,
                          delegateQueue: nil)
    }()
    
    var receivedData: Data?
    
    private let gallery: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        listAllPlanets()
        
        gallery.register(ImageCell.self,
                         forCellWithReuseIdentifier: ImageCell.identifier)
        gallery.delegate = self
        gallery.dataSource = self
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Updating screen background color in main thread queue
            self.view.backgroundColor = .white
        }
        view.addSubview(gallery)
        activateRegularConstraints()
    }
    
    private func activateRegularConstraints() {
        NSLayoutConstraint.activate([
            gallery.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            gallery.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gallery.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gallery.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
    private func listAllPlanets() {
        let planetsQueue = DispatchQueue(
            label: "com.leodmgs.SpaceGallery.planetsQueue",
            qos: .utility)
        planetsQueue.async {
            let solarSystemPlanets = self.planets
            solarSystemPlanets.forEach { planet in
                print(planet)
            }
        }
    }
    
    private func downloadImage(_ indexPath: IndexPath) {
        guard let stringUrl = self.datasource[indexPath] else { return }
        let url = URL(string: stringUrl)!
        self.receivedData = Data()
        let task = session.dataTask(with: url)
        task.resume()
    }
    
}


extension LoadAsyncImageController: URLSessionDataDelegate {

    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse,
        completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        // Convert the respose object to HTTPURLRespose to get information
        // about the status code and mime-type to handle the response properly.
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode),
            let mimeType = response.mimeType,
            mimeType == "image/jpeg" else {
                // if it is not possible to convert to HTTPURLResponse or if the
                // status code isn't between 200 and 299 or the mime type isn't
                // image/jpeg, it means that the response just failed. In this
                // way, the callback is called cancelling to proceed.
                completionHandler(.cancel)
                return
        }
        // Once the response was successfully received, it can proceed with
        // the data handling.
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        // Stores the data received by the URLSession into local property.
        self.receivedData?.append(data)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        // The session has finished its work. After that, it need to update
        // the UI by calling the main queue to do that. In the async statement,
        // if the error object is valid, which means that some error has been
        // created, the UI needs to be updated informing that something was
        // wrong. Otherwise, if the error is 'nil', any error has happened and
        // the UI can be updated properly.
        DispatchQueue.main.async {
            if let error = error {
                print("Request session has failed. \(error)")
            } else if let data = self.receivedData {
                self.profileImage.image = UIImage(data: data)
            }
        }
    }
}

extension LoadAsyncImageController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCell.identifier,
            for: indexPath) as! ImageCell2
//        if let url = datasource[indexPath] {
//            imageCell.thumbnail.fetchImage(url)
//        }
        return imageCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
}


private class ImageCell2: UICollectionViewCell {
    
    static let identifier = "com.leodmgs.SpaceGallery.ImageCell.identifier"
    
//    private let activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView()
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//        indicator.color = .gray
//        return indicator
//    }()
    
    let thumbnail: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupView() {
//        backgroundColor = .lightGray
        addSubview(thumbnail)
//        thumbnail.addSubview(activityIndicator)
//        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            
            thumbnail.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnail.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            thumbnail.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),
            thumbnail.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
//            activityIndicator.topAnchor.constraint(
//                equalTo: thumbnail.topAnchor),
//            activityIndicator.leadingAnchor.constraint(
//                equalTo: thumbnail.leadingAnchor),
//            activityIndicator.trailingAnchor.constraint(
//                equalTo: thumbnail.trailingAnchor),
//            activityIndicator.bottomAnchor.constraint(
//                equalTo: thumbnail.bottomAnchor)
            
            ])
        
//        activityIndicator.startAnimating()
    }
    
}
