//
//  GlobalGivingApi.swift
//  GlobalGiving
//
//  Created by Steven Rogers on 11/30/17.
//  Copyright © 2017 Envieta. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

//let FEATURED_PROJECTS = "https://api.globalgiving.org/api/public/projectservice/featured/projects/summary.json?api_key="
let FEATURED_PROJECTS = "https://api.globalgiving.org/api/public/projectservice/featured/projects.json?api_key="
let ALL_PROJECTS = "https://api.globalgiving.org/api/public/projectservice/all/projects/active/summary.json?api_key="
public let apiKey = "40d907a7-730e-4d38-9b8e-8fbce0ad2e7d" // steve's API key

struct projectReq: Codable {
    var projects: Projects?
}
struct Projects: Codable {
    var numberFound: Int
    var project: [Project]
    var hasNext:Bool? = false
    var nextProjectId:Int?
}
//struct ggProject: Codable {
//    var id:Int = 0
//    var title:String = ""
//    var country:String = ""
//    var imageLink:String = ""
////    var image:UIImage?
//}

typealias ProjectResult = ([Project]?, String) -> ()

internal class GlobalGivingApi {
    
    var projects: [Project] = []
    var errorMessage = ""
    
    func getFeaturedProjects(completion: @escaping ProjectResult) {
        getProjects(FEATURED_PROJECTS + apiKey, completion)
    }
    
    internal func getProjects(_ url: String, _ completion: @escaping ProjectResult) {
        let url = FEATURED_PROJECTS + apiKey
        request(url).responseData { response in
                switch response.result {
                case .success:
                    do {
                        let decoder = JSONDecoder()
                        let decodedProjects = try decoder.decode(projectReq.self, from: response.data!)
//                        let encoder = JSONEncoder()
//                        encoder.outputFormatting = JSONEncoder.OutputFormatting([JSONEncoder.OutputFormatting.prettyPrinted, JSONEncoder.OutputFormatting.sortedKeys])
//                        try print("Using Decoder===>\(String(data: (encoder.encode(decodedProjects)), encoding: .utf8)! )\n\n\n\n")
                        self.projects.removeAll()
                        self.projects = decodedProjects.projects!.project
                        var ids:[Int] = []
                        for p in self.projects {
                            ids.append(p.id)
                        }
                        print("Downloaded project set:\n\(ids)")
//                        let url = self.projects[0].image?.getImageUrl(size: .large)
//                        print(url)
                        // Set 
                        DispatchQueue.main.async {
                            completion(self.projects, self.errorMessage)
                        }
                    } catch {
                        print("Error converting to JSON using decoder...\(error)")
                    }
                    break
                case .failure(let error):
                    print("Error in response: \(error)")
                    self.projects.removeAll()
                    self.errorMessage = "Error: \(error)"
                    // TODO Handle specific error from api message.
                }
//                do {
//                    let decoder = JSONDecoder()
//                    let decodedProjects = try decoder.decode(projectReq.self, from: response.data!)
//                    let encoder = JSONEncoder()
//                    encoder.outputFormatting = JSONEncoder.OutputFormatting([JSONEncoder.OutputFormatting.prettyPrinted, JSONEncoder.OutputFormatting.sortedKeys])
//                    try print("Using Decoder===>\(String(data: (encoder.encode(decodedProjects)), encoding: .utf8)! )\n\n\n\n")
//                    result = decodedProjects.projects!.project
//                    let url = result[0].image?.getImageUrl(size: .large)
//                    print(url)
//                } catch {
//                    print("Error converting to JSON using decoder...\(error)")
//                }
            }
//            .responseJSON { response in
//                print("JSON>>>>>> \(response.result.value)")
//        }
        
//        print(result)
//        return result
    }
}
