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
    var lastMessage = Message()
}

class Message : MasterMessage {
    var senderId : String = ""
}
