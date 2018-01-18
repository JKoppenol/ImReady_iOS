//
//  ChatService.swift
//  ImReady
//
//  Created by Inholland on 12/7/17.
//  Copyright © 2017 Inholland. All rights reserved.
//

import Foundation
import Alamofire


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
    
//    func mockData() -> Chat {
//        
//        let tempChat = Chat()
//        tempChat.id = ""
//        tempChat.senderId = "1"
//        tempChat.receiverId = "2"
//        
//        var msg = Message()
//        msg.id = 1
//        msg.receiverId = "2"
//        msg.senderId = "1"
//        msg.content = "Hoi Jeroen!"
//        
//        tempChat.messages.append(msg)
//        
//        msg = Message()
//        msg.id = 2
//        msg.receiverId = "1"
//        msg.senderId = "2"
//        msg.content = "Hey Ralph! Alles goed?"
//        
//        tempChat.messages.append(msg)
//        
//        return tempChat
//    }
    
    let apiClient: ApiClient = ApiClient()
    
    public func getChats(ofUserWithId userId: String,
                                onSuccess: @escaping (_ : [Chat]) -> (),
                                onFailure: @escaping () -> ()) {
        apiClient.send(toRelativePath: "user/\(userId)/chats",
            withHttpMethod: .get,
            onSuccessDo: { (_ data) in
                var chats : [Chat] = []
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as! [[String:Any]]
                    
                    for object in json {
                        let chat = ChatResult(withData: object) as Chat
                        chats.append(chat)
                    }
                    
                    onSuccess(chats)
                }
                catch {
                    onFailure()
                }
            },
            onFailure: onFailure)
    }
    
    public func send(message: Message,
                      onSuccess: @escaping () -> (),
                      onFailure: @escaping () -> ()) -> () {
        let senderId = message.senderId
        let receiverId = message.receiverId
        
        apiClient.send(toRelativePath: "user/\(senderId)/chat/\(receiverId)",
                       withHttpMethod: .post,
                       withParameters: ["Content": message.content],
                       withHeaders: ["Content-Type": apiClient.ContentTypeHeader, "Accept": apiClient.AcceptHeader],
                       withEncoding: URLEncoding.httpBody,
                       onSuccessDo: { (_ data) in
                        
            },
                       onFailure: onFailure)
    }

}
let chatService : ChatService = ChatService()
