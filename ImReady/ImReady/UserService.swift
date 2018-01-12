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
        User1.name = "Ralph Hink"
        User1.email = "ralph@test.nl"
        User1.id = 1
        User1.password = "test"
        User1.role = .Caretaker
        
        let User2 = User()
        User2.name = "Jeroen Koppenol"
        User2.email = "jeroen@test.nl"
        User2.id = 2
        User2.password = "test"
        User2.role = .Client
        
        
        var users : [User] = []
        users.append(User1)
        users.append(User2)
        
        return users;
    }
    
    func getById(id : Int) -> User? {
        let users = getAllUsers()
        
        for user in users {
            if(user.id == id) {
                return user
            }
            
            continue
        }
        
        return nil
    }

}

let userService: UserService = UserService()
