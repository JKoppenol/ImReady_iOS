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
    
    @IBOutlet weak var receivedMessageView: UIView!
    @IBOutlet weak var sendMessageView: UIView!
    
    
    var message: Message!
    var currentUser = User()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(message: Message, currentUser: User) {
        self.message = message
        
        if message.senderId == currentUser.id {
         
            sendMessageView.isHidden = false
            sendMessageLbl.text = message.content
            
            receivedMessageLbl.text = ""
            receivedMessageView.isHidden = true
        }
        
        else {
            sendMessageView.isHidden = true
            sendMessageLbl.text = ""
            
            receivedMessageLbl.text = message.content
            receivedMessageView.isHidden = false
        }
    }

}
