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
    var id : Int = 0
    var senderId : Int = 0
    var receiverId : Int = 0
    var messages : [Message] = []
}

class Message {
    var id : Int = 0
    var senderId : Int = 0
    var receiverId : Int = 0
    var content : String = ""
    var date : Date = Date()
}
