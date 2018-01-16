//
//  ComponentTasksVC.swift
//  ImReady
//
//  Created by Inholland on 1/12/18.
//  Copyright © 2018 Inholland. All rights reserved.
//
import Foundation
import UIKit

class ComponentTasksVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var currentUser = sharedInstance.currentUser
    var tasks = [ComponentTask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(tasks.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = tasks[indexPath.row]
    
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Task") as? TaskCell {
            cell.configCell(task: task)
            
            return(cell)
        }
            
        else {
            return TaskCell()
        }
    }
}
