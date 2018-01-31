//
//  Chat.swift
//  ImReady
//
//  Created by Inholland on 12/5/17.
//  Copyright © 2017 Inholland. All rights reserved.
//

import UIKit

class Chats {
    var results : [Chat] = []
}

class Chat {
    var id : String = ""
    var senderId : String = ""
    var receiverId : String = ""
    var messages : [Message] = []
    
    public func lastMessage() -> Message? {
        if(self.messages.count != 0) {
            
            let lastMessage = self.messages.last!
            
            if(lastMessage.id != "") {
                return lastMessage
            }
        }
        
        return nil
    }
}

class Message : MasterMessage {
    var senderId : String = ""
}
