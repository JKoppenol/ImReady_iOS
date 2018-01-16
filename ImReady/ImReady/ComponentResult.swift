//
//  ComponentResult.swift
//  ImReady
//
//  Created by Inholland on 1/16/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class ComponentResult : Component {
    init(withData data:[String:Any]) {
        super.init()
        name = data["Name"] as! String
        description = data["Description"] as! String
        tasks = data["Tasks"] as! [ComponentTaskResult]
        youtubeUrl = data["YoutubeURL"] as! String
        usefulLinks = data["UsefulLinks"] as! [String:String]
        id = data["Id"] as! String
    }
}
