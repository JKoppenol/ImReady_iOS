//
//  MessagesCell.swift
//  ImReady
//
//  Created by Inholland on 12/14/17.
//  Copyright © 2017 Inholland. All rights reserved.
//

import UIKit

class MessagesCell: UITableViewCell {

    @IBOutlet weak var receivedMessageLbl: UILabel!
    @IBOutlet weak var sendMessageLbl: UILabel!
    @IBOutlet weak var receivedDate: UILabel!
    
    @IBOutlet weak var receivedMessageView: UIView!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var sendDate: UILabel!
    
    var message: Message!
    var currentUser = sharedInstance.currentUser
    var dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(message: Message) {
        self.message = message
        let currentUser = LoggedInUser().getLoggedInUser()
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "nl_NL")
        
        receivedMessageView.layer.cornerRadius = 8.0
        sendMessageView.layer.cornerRadius = 8.0
        
        if message.senderId == currentUser.id {
         
            sendMessageView.isHidden = false
            sendMessageLbl.text = message.content
            sendDate.text = dateFormatter.string(from: message.date)
            
            receivedMessageLbl.text = ""
            receivedMessageView.isHidden = true
            receivedDate.text = ""
        }
        
        else {
            sendMessageView.isHidden = true
            sendMessageLbl.text = ""
            sendDate.text = ""
            
            receivedMessageLbl.text = message.content
            receivedMessageView.isHidden = false
            receivedDate.text = dateFormatter.string(from: message.date)
        }
    }

}
