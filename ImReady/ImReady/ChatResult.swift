//
//  ChatResult.swift
//  ImReady
//
//  Created by Inholland on 1/17/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class ChatResult : Chat {
    init(withData data: [String:Any]) {
        super.init()
        self.id = data["Id"] as! String
        self.senderId = data["SenderId"] as! String
        self.receiverId = data["ReceiverId"] as! String
        
        for object in data["Messages"] as! [[String:Any]] {
            var messageReceiverId: String = ""
            
            //if ChatSender = LoggedinUser and MessageSender = LoggedinUser -> MessageReceiver = ChatReceiver
            if(senderId == LoggedInUser.currentuser.id) {
                if(object["SenderId"] as? String == LoggedInUser.currentuser.id) {
                    messageReceiverId = receiverId
                }
                else { messageReceiverId = senderId }
            }
                
            //else means ChatSender != LoggedinUser
            else {
                if(object["SenderId"] as? String == senderId) {
                    messageReceiverId = receiverId
                }
                else { messageReceiverId = senderId }
            }
            
            self.messages.append(MessageResult(withData: object, andChatReceiverId: messageReceiverId) as Message)
        }
    }
}
