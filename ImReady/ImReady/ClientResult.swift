//
//  ClientResult.swift
//  ImReady
//
//  Created by Inholland on 1/31/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class ClientResult : User {
    init(withData data: [String:Any]) {
        super.init()
        id = data["Id"] as! String
        FirstName = data["FirstName"] as! String
        LastName = data["LastName"] as! String
    }
}
