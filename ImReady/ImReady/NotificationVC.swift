//
//  NotificationVC.swift
//  ImReady
//
//  Created by Inholland on 1/5/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var notifications = [Notification]()
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        currentUser = sharedInstance.currentUser!
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(currentUser.id == 1) {
            return 0
        }
        
        return(notifications.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let notification = notifications[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Notification") as? NotificationCell {
            cell.configCell(notification: notification, currentUser: currentUser)
            
            return(cell)
        }
            
        else {
            return NotificationCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toTask") {
            guard let destination = segue.destination as? ComponentVC else {return}
            destination.segmentedControl.selectedSegmentIndex = 1
            //code for setting component
            //code for expanding specific task of notification
        }
    }
    
    func loadData() {
        notifications = notificationService.mockData()
    }
}
