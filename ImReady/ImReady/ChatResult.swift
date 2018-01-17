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
        
        for object in data["Messages"] as! [[String:Any]] {
            self.messages.append(MessageResult(withData: object) as Message)
        }
    }
}
