//
//  QueryService.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 2/18/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

class QueryService {
    
    private let urlBaseString: String = "https://images-api.nasa.gov"
    
    func searchImages(
        query: String,
        _ limitResults: Int? = 50,
        completion: @escaping (Array<ImageMetadata>) -> ()) {
        
        let urlObject =
            URL(string: "\(urlBaseString)/search?q=\(query)&media_type=image")!
        let task = URLSession.shared.dataTask(with: urlObject) {
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
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let imagesMetadata =
                        self.items(jsonItems: json["collection"]["items"])
                    completion(imagesMetadata)
                } catch SwiftyJSONError.invalidJSON {
                    print("[Error] Invalid JSON.")
                } catch {
                    print("Unexpected error: \(error)")
                }
            }
        }
        task.resume()
    }
    
    private func items(jsonItems: JSON) -> Array<ImageMetadata> {
        var items = Array<ImageMetadata>()
        for item in jsonItems.arrayValue {
            do {
                let imageMetadata = try ImageMetadata(json: item)
                items.append(imageMetadata)
            } catch let urlError as URLError {
                print("[Error]: Bad URL\n\t-> \(urlError.errorUserInfo)")
            } catch {
                print("Unexpected error: \(error)")
            }
        }
        return items
    }
    
}
