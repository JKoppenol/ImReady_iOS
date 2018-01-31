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
    
    public func getOrCreateChat(ofSenderId sender: String,
                                toReceiverId receiver: String,
                                onSuccess: @escaping (_ : Chat) -> (),
                                onFailure: @escaping () -> ()) {
        let senderId: String! = sender
        let receiverId: String! = receiver
        
        apiClient.send(toRelativePath: "user/\(senderId!)/chat/\(receiverId!)",
            withHttpMethod: .get,
            onSuccessDo: { (_ data) in
                var chat : Chat = Chat()
                 
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                    
                    if let error = json["error-description"] as? String {
                        print(error)
                        onFailure()
                    }
                    else {
                        chat = ChatResult(withData: json) as Chat
                        onSuccess(chat)
                    }
                }
                catch {
                    onFailure()
                }
            },
            onFailure: onFailure)
    }
    
    public func send(sentMessage: Message,
                     onSuccess: @escaping (_ : Message) -> (),
                     onFailure: @escaping () -> ()) -> () {
        let senderId: String! = sentMessage.senderId
        let receiverId: String! = sentMessage.receiverId
        
        apiClient.send(toRelativePath: "user/\(senderId!)/chat/\(receiverId!)",
                       withHttpMethod: .post,
                       withParameters: ["Content": sentMessage.content],
                       withHeaders: ["Content-Type": apiClient.ContentTypeHeader, "Accept": apiClient.AcceptHeader],
                       withEncoding: URLEncoding.httpBody,
                       onSuccessDo: { (_ data) in
                        var message: Message = Message()
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                            
                            message = MessageResult(withData: json, andChatReceiverId: receiverId) as Message
                            
                            onSuccess(message)
                        }
                        catch {
                            onFailure()
                        }
            },
                       onFailure: onFailure)
    }

}
let chatService : ChatService = ChatService()
