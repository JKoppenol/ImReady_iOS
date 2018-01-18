//
//  LoggedInUser.swift
//  ImReady
//
//  Created by Ralph Hink on 11/01/2018.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation
import Locksmith

class LoggedInUser {
    var id : String?
    var access_token: String?
    var username: String?
    var user_type : Role?
    var isLoggedIn: Bool {
        get{
            return access_token != nil
        }
    }
    var caretakerId: String?
    
    func getLoggedInUser() -> LoggedInUser {
        let user: LoggedInUser = LoggedInUser()
        let userDict = Locksmith.loadDataForUserAccount(userAccount: "loggedInUser")
        if(userDict == nil) {
            return user
        }
        
        user.id = userDict?["id"] as? String
        user.access_token = userDict?["access_token"] as? String
        user.username = userDict?["firstname"] as? String
        user.user_type = Role(rawValue: (userDict?["user_type"] as? String)!)
        
        if(user.user_type == .Client) {
            user.caretakerId = userDict?["caretakerId"] as? String
        }
        
        return user
    }
}
