//
//  ChatCell.swift
//  ImReady
//
//  Created by Inholland on 1/12/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lastSentMessageLabel: UILabel!
    
    var currentUser = sharedInstance.currentUser

    var chat = Chat()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(chat: Chat, currentUser: User) {
        let lastMessageTime = chat.messages.last?.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        nameLabel.text = getRecipientName()
        timeLabel.text = dateFormatter.string(from: lastMessageTime!)
        lastSentMessageLabel.text = chat.messages.last?.content
    }
    
    private func getRecipientName() -> String {
        if(currentUser?.id == chat.receiverId) {
            let sender = userService.getById(id: chat.senderId)
            
            if(sender != nil) {
                return sender!.name
            }
            
            return ""
        }
        
        else {
            let receiver = userService.getById(id: chat.receiverId)
            
            if(receiver != nil) {
                return receiver!.name
            }
            
            return ""
        }
    }
}
