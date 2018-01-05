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
        currentUser.id = 2
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
    
    func loadData() {
        notifications = notificationService.mockData()
    }

}
