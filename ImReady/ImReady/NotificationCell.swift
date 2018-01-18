//
//  NotificationCell.swift
//  ImReady
//
//  Created by Inholland on 1/5/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    let currentUser = LoggedInUser().getLoggedInUser()
    
    var dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configCell(notification: Notification) {
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        if(notification.receiverId == currentUser.id) {
            titleLabel.text = notification.title
            dateLabel.text = dateFormatter.string(from: notification.date)
            contentLabel.text = notification.content
        }
    }
}
