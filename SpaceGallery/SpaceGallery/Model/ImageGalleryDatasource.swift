//
//  ImageGalleryDatasource.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/18/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation

class ImageGalleryDatasource {
    
    static let shared = ImageGalleryDatasource()
    
    private let concurrentQueue: DispatchQueue = {
        return DispatchQueue(
            label: "com.leodmgs.SpaceGallery.ImageGalleryDatasource",
            attributes: .concurrent)
    }()
    
    private var unsafeDatasource = Array<ImageMetadata>()
    
    var datasource: Array<ImageMetadata>? {
        var datasourceCopy = Array<ImageMetadata>()
        concurrentQueue.sync {
            datasourceCopy.append(contentsOf: unsafeDatasource)
        }
        return datasourceCopy
    }
    
    // MARK: if the datasource was updated, an event needs to be performed
    // to the controller to update the view as well.
    
    func append(dataCollection: Array<ImageMetadata>) {
        concurrentQueue.sync {
            unsafeDatasource.append(contentsOf: dataCollection)
        }
    }
    
    func append(dataElement: ImageMetadata) {
        concurrentQueue.sync {
            unsafeDatasource.append(dataElement)
        }
    }
    
    func dropDatasource() {
        concurrentQueue.sync {
            unsafeDatasource.removeAll()
        }
    }
    
    func index(at: Int) -> ImageMetadata? {
        if at > unsafeDatasource.count-1 || at < 0 {
            return nil
        }
        var imageMetadata: ImageMetadata?
        concurrentQueue.sync {
            imageMetadata = unsafeDatasource[at]
        }
        if let img = imageMetadata {
            return img
        }
        return nil
    }
    
    private init() {}
    
    
}
