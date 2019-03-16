//
//  Project.swift
//  GlobalGiving
//
//  Created by Steven Rogers on 12/5/17.
//  Copyright © 2017 Envieta. All rights reserved.
//

import Foundation

enum imageSize:String, Codable {
    case small = "small"
    case medium = "medium"
    case large = "large"
    case extraLarge = "extraLarge"
    case original = "original"
    case thumbnail = "thumbnail"
}
struct imageLink: Codable {
    var size:imageSize?
    var url:String = ""
    
    func getUrl(size:imageSize) -> URL? {
        return URL(string: url)
    }
}
struct image: Codable {
    var id:Int = 0
    var title:String = ""
    var imagelink:[imageLink]
    
    func getImageUrl(size:imageSize) -> String? {
        var result:String? = nil
        for img in imagelink {
            if img.size == size {
                result = img.url
            }
        }
        return result
    }
}
class Project: Codable {
    var id:Int = 0
    var title:String = ""
//    var imageLink:String = ""
    var iso3166CountryCode:String = ""
    var country:String = ""
    var funding:Double = 0
    var imageGallerySize:Int = 0
    var image:image?
    var summary:String = ""
}
