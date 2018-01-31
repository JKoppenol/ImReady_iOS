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
    
    var currentUser = LoggedInUser().getLoggedInUser()
    var lastMessage: Message?
    var chat = Chat()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(chat: Chat) {
        self.chat = chat
        lastMessage = chat.lastMessage()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        getRecipientName()
        
        if(lastMessage != nil) {
            timeLabel.text = dateFormatter.string(from: (lastMessage?.date)!)
            
            lastSentMessageLabel.text = lastMessage?.content
        }
        
        else {
            lastSentMessageLabel.textColor = UIColor.gray
            lastSentMessageLabel.text = "Nog geen berichten."
        }
    }
    
    private func getRecipientName() {
        self.nameLabel.text = "Gebruiker ophalen..."
    
        if(currentUser.id == chat.receiverId) {
            var sender: User = User()
            userService.getUser(withId: chat.senderId,
                                             withRole: self.currentUser.user_type!,
                                             onSuccess: { (user) in
                                                sender = user
                                                self.nameLabel.text = sender.getFullName()
                                                if(self.lastMessage != nil && self.lastMessage?.senderId == sender.id) {
                                                    self.lastSentMessageLabel.text = sender.FirstName + ": " + (self.lastMessage?.content)!
                                                }
                                                
                                                else {
                                                    if(self.lastMessage != nil) {
                                                        self.lastSentMessageLabel.text = "Ik: " + (self.lastMessage?.content)!
                                                    }
                                                }
                },
                                             onFailure: {
                                                print("Could not find user.")
            })
        }
        
        else {
            var receiver: User = User()
            if(currentUser.id == chat.receiverId) {
                userService.getUser(withId: chat.senderId,
                                    withRole: self.currentUser.user_type!,
                                    onSuccess: { (user) in
                                        receiver = user
                                        self.nameLabel.text = receiver.getFullName()
                                        if(self.lastMessage != nil && self.lastMessage?.senderId == receiver.id) {
                                            self.lastSentMessageLabel.text = receiver.FirstName + ": " + (self.lastMessage?.content)!
                                        }
                                            
                                        else {
                                            if(self.lastMessage != nil) {
                                                self.lastSentMessageLabel.text = "Ik: " + (self.lastMessage?.content)!
                                            }
                                        }
                    },
                                    onFailure: {
                                        print("Could not find user.")
                })
            }
        }
    }
}
