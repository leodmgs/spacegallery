//
//  ImageMetadata.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/18/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import SwiftyJSON
import TRON

struct ImageMetadata: JSONDecodable {
    
    var id: String
    var url: URL
    var title: String
    var description: String
    
    init(json: JSON) {
        let data = json["data"].arrayValue
        self.id = data[0]["nasa_id"].stringValue
        self.title = data[0]["title"].stringValue
        self.description = data[0]["description"].stringValue
        
        let links = json["links"].arrayValue
        self.url = URL(string: links[0]["href"].stringValue)!
    }
    
    func debugString() {
        print("ID: \(id)")
        print("URL: \(url.absoluteString)")
        print("Title: \(title)")
        print("Description: \(description)\n--------\n")
    }
    
}
