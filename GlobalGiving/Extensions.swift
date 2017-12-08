//
//  Extensions.swift
//  GlobalGiving
//
//  Created by Steven Rogers on 12/8/17.
//  Copyright © 2017 Envieta. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireImage

var imageCache:[Int:UIImage] =  [:]

extension UIImageView {
    func downloadImageFrom(url: String, projectId: Int, contentMode: UIViewContentMode) {
        Alamofire.request(url).responseImage { response in
            switch response.result {
            case .success:
                if let image = response.result.value {
                    imageCache[projectId] = image
                    self.image = image
                } else {
                    print("Could not retrieve image from response...")
                }
            case .failure(let error):
                print("Error requesting '\(url)': \(error)")
            }
    }
    }
}
