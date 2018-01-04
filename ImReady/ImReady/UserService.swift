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
        User1.name = "Gerard"
        User1.id = 1
        
        let User2 = User()
        User2.name = "Joeri"
        User2.id = 2
        
        var users : [User] = []
        users.append(User1)
        users.append(User2)
        
        return users;
    }
    
    func getById(id : Int) -> User? {
        let users : [User] = getAllUsers()
        
        for user in users {
            if(user.id == id) {
                return user
            }
        }
        
        return nil
    }

}

let userService: UserService = UserService()
