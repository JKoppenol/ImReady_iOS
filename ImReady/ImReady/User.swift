//
//  User.swift
//  ImReady
//
//  Created by Ralph Hink on 05/12/2017.
//  Copyright © 2017 Inholland. All rights reserved.
//

import Foundation

class User : Model {
    var firstname : String
    var lastname : String
    var role : Role

    
    init(id: String, firstname: String, lastname: String, role: Role){
        super.init()
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.role = role
    }
}


//class User {
//    var Id : String = ""
//    var UserName : String = ""
//    var FirstName : String = ""
//    var LastName : String = ""
//    var PhoneNumber : String = ""
//    var PasswordHash : String = ""
//    var Email : String = ""
//    var Roles : Role = Role()
//    var AccessFailedCount : Int = 0
//    }

enum Role : String {
    case Client = "CLIENT"
    case Caregiver = "CAREGIVER"
}
