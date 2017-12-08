//
//  ViewController.swift
//  GlobalGiving
//
//  Created by Steven Rogers on 11/29/17.
//  Copyright © 2017 Envieta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var projectTableView: UITableView!
    
    var projects:[Project] = []
    var api = GlobalGivingApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Starting")
        let projects = api.getFeaturedProjects() { projects, errorMessage in
            if let projects = projects {
                self.projects = projects
                self.projectTableView.reloadData()
                self.projectTableView.setContentOffset(CGPoint.zero, animated: false)
            }
        }
        print("projects=\(self.projects.count)")
        print("done")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProjectCell = tableView.dequeueReusableCell( withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
//        let c2: ProjectCell = tableView.dequeueReusableCell(for: indexPath) as! ProjectCell
        
        
//        cell.delete(self)
        let project = projects[indexPath.row]
        cell.configure(project: project, rowNumber: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    

}
