//
//  ProjectCell.swift
//  GlobalGiving
//
//  Created by Steven Rogers on 12/6/17.
//  Copyright © 2017 Envieta. All rights reserved.
//

import Foundation
import UIKit

class ProjectCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var projectImage: UIImageView!
    
    func configure(project: Project, rowNumber:Int) {
        title.text = project.title + " (" + String(project.id) + ")"
        print("Displaying \(project.id) with summary: \(project.summary)")
        if let image = imageCache[project.id] {
            print("Loading image from cache for \(project.id)")
            projectImage.image = image
        } else {
            print("Downloading image for \(project.id)")
            projectImage.downloadImageFrom(url: project.image!.getImageUrl(size: imageSize.small)!, projectId: project.id, contentMode: UIView.ContentMode.scaleAspectFit)
        }
    }
}
