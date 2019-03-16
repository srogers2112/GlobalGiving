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
    /**
     Extension of UIImageView to enable the UIImageView component to load itself from a URL
    */
    func downloadImageFrom(url: String, projectId: Int, contentMode: UIView.ContentMode) {
        Alamofire.request(url).responseImage { response in
            //callback/completion handler to handle response asynchronously
            switch response.result {
            case .success:
                if let image = response.result.value {
                    // cache image
                    imageCache[projectId] = image
                    // and assign it to self's image attribute
                    self.image = image
                } else {
                    print("Could not retrieve image from response...")
                    // TODO should any action be taken, such as a default image being displayed (a red X?)
                }
            case .failure(let error):
                print("Error requesting '\(url)': \(error)")
                // TODO should any action be taken, such as a default image being displayed (a red X?)
            }
    }
    }
}
