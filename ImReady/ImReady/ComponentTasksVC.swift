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
    
    var currentUser = LoggedInUser().getLoggedInUser()
    var tasks = [ComponentTask]()
    var component = Component()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = component.tasks
        nameLabel.text = component.name
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    @IBAction func readyAction(_ sender: Any) {
        createAlert(title: "Taak afgerond!", message: "Er is een bericht naar je zorgverlener gestuurd, die zal de taak beoordelen!")
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
    
    private func createAlert(title: String!, message: String!) {
        deactivateIndicator_Activity()
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Oke", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "unwindSegueToFCReady", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}
