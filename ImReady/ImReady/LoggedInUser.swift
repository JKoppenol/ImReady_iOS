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
    
    func getLoggedInUser() -> LoggedInUser {
        let user: LoggedInUser = LoggedInUser()
        let userDict = Locksmith.loadDataForUserAccount(userAccount: "loggedInUser")
        if(userDict == nil) {
            return user
        }
        
        user.id = userDict?["id"] as! String
        user.access_token = userDict?["access_token"] as! String
        user.username = userDict?["firstname"] as! String
        user.user_type = Role(rawValue: userDict?["user_type"] as! String)
        
        return user
    }
    
//    func logoutAndClean() {
//        LoggedInUser.currentuser.id = nil
//        LoggedInUser.currentuser.access_token = nil
//        LoggedInUser.currentuser.user_type = nil
//        LoggedInUser.currentuser.username = nil
//    }
}
