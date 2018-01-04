//
//  User.swift
//  ImReady
//
//  Created by Ralph Hink on 05/12/2017.
//  Copyright © 2017 Inholland. All rights reserved.
//

import Foundation

class User {
    var id : Int = 0
    var name : String = ""
    var phone : String = ""
    var password : String = ""
    var email : String = ""
    var role : Role = .Client
    var modules : [Int] = []
    var contactid : Int = 0
    var image : String = ""
    
    }

enum Role: String {
    case Caretaker
    case Client
}
