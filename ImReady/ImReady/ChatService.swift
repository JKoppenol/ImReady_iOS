//
//  ChatService.swift
//  ImReady
//
//  Created by Inholland on 12/7/17.
//  Copyright © 2017 Inholland. All rights reserved.
//

import Foundation
//


class ChatService {
    func getAllFrom(userId: Int) -> [Chat]? {
//        var ownedChats : [Chat] = []
//        
//        let chats = mockData()
//        
//        for chat in chats {
//            if(chat.senderId == userId) {
//                ownedChats.append(chat)
//            }
//        }
//        
//        return ownedChats
        return nil
    }
    
    func mockData() -> Chat {
        
        let tempChat = Chat()
        tempChat.id = 1
        tempChat.senderId = 1
        tempChat.receiverId = 2
        
        var msg = Message()
        msg.id = 1
        msg.receiverId = 2
        msg.senderId = 1
        msg.content = "Hoi Gebruiker!"
        
        tempChat.messages.append(msg)
        
        msg = Message()
        msg.id = 2
        msg.receiverId = 1
        msg.senderId = 2
        msg.content = "Hey Jaap!"
        
        tempChat.messages.append(msg)
        
        return tempChat
    }
}
let chatService : ChatService = ChatService()
