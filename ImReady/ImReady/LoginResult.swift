//
//  LoginResult.swift
//  ImReady
//
//  Created by Ralph Hink on 11/01/2018.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class LoginResult {
    let access_token : String
    let token_type : String
    let expires_in : Double
    let user_type : String
    let user_id : String
    let firstname : String
    let issued : String
    let expires : String
    
    init(json data:[String:Any]) {
        self.access_token = data["access_token"] as! String
        self.token_type = data["token_type"] as! String
        self.expires_in = data["expires_in"] as! Double
        self.user_type = data["user_type"] as! String
        self.user_id = data["user_id"] as! String
        self.firstname = data["firstname"] as! String
        self.issued = data["issued"] as! String
        self.expires = data["expires"] as! String
    }
}
