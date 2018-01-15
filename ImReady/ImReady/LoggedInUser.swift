//
//  LoggedInUser.swift
//  ImReady
//
//  Created by Ralph Hink on 11/01/2018.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class LoggedInUser {
    static let currentuser = LoggedInUser()
    
    var id : String?
    var access_token: String?
    var username: String?
    var user_type : Role?
    var isLoggedIn: Bool {
        get{
            return access_token != nil
        }
    }
    
    func logoutAndClean() {
        LoggedInUser.currentuser.id = nil
        LoggedInUser.currentuser.access_token = nil
        LoggedInUser.currentuser.user_type = nil
        LoggedInUser.currentuser.username = nil
    }
}
