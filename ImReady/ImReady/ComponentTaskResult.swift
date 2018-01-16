//
//  ComponentTaskResult.swift
//  ImReady
//
//  Created by Inholland on 1/16/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class ComponentTaskResult : ComponentTask {
    init(withData data:[String:Any]) {
        super.init()
        let dateFormatter = DateFormatter()
        
        name = data["Name"] as! String
        description = data["Description"] as! String
        deadline = dateFormatter.date(from: data["DeadlineDate"] as! String)!
        status = data["Status"] as! Int
        feedback = data["Feedback"] as! String
        id = data["Id"] as! String
    }
}
