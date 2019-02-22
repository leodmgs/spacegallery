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
    var url: URL?
    var title: String
    var description: String
    
    init(json: JSON) throws {
        let data = json["data"].arrayValue
        self.id = data[0]["nasa_id"].stringValue
        self.title = data[0]["title"].stringValue
        self.description = data[0]["description"].stringValue
        
        let links = json["links"].arrayValue
        guard let hrefURL = URL(string: links[0]["href"].stringValue) else {
            throw URLError(
                .badURL,
                userInfo: ["url" : links[0]["href"].stringValue])
        }
        self.url = hrefURL
    }
    
    func debugString() {
        print("ID: \(id)")
        print("URL: \(url?.absoluteString ?? "none")")
        print("Title: \(title)")
        print("Description: \(description)\n--------\n")
    }
    
}
