//
//  UserService.swift
//  ImReady
//
//  Created by Inholland on 12/7/17.
//  Copyright © 2017 Inholland. All rights reserved.
//

import Foundation

class UserService {
    func getAllUsers() -> [User] {
        let User1 = User()
        User1.name = "Ralph"
        User1.email = "ralph@test.nl"
        User1.id = "1"
        User1.password = "test"
        User1.role = .Caregiver
        
        let User2 = User()
        User2.name = "Jeroen"
        User2.email = "jeroen@test.nl"
        User2.id = "2"
        User2.password = "test"
        User2.role = .Client
        
        
        var users : [User] = []
        users.append(User1)
        users.append(User2)
        
        return users;
    }
    
    func getUser(withId userId: String,
                 withRole role: Role,
                 onSuccess: @escaping (_ : User) -> (),
                 onFailure: @escaping () -> ()) {
        let apiClient: ApiClient = ApiClient()
        var path: String = ""
        var tempRole: Role = .Client
        
        if(role == .Client) {
            path = "caregiver/\(userId)"
            tempRole = .Caregiver
        }
        
        else if(role == .Caregiver) {
            path = "client/\(userId)"
            tempRole = .Client
        }
        
        apiClient.send(toRelativePath: path,
                       withHttpMethod: .get,
                       onSuccessDo: { (_ data) in
                        let user : User = User()
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                            user.id = json["Id"] as! String
                            user.FirstName = json["FirstName"] as! String
                            user.LastName = json["LastName"] as! String
                            user.role = tempRole
                            
                            onSuccess(user)
                        }
                        catch {
                            onFailure()
                        }
            },
                       onFailure: onFailure)
    }

}

let userService: UserService = UserService()
