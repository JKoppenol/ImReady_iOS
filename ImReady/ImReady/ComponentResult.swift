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
        
        if(data["Tasks"] != nil) {
            tasks = data["Tasks"] as! [ComponentTaskResult]
        }
    
        youtubeUrl = String(describing: data["YoutubeURL"])
        
        for object in data["UsefulLinks"] as! [[String:Any]] {
            usefulLinks.append(String(describing: object["Url"]))
        }
        
        id = data["Id"] as! String
    }
}
