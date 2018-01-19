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
        
        if(data["Description"] is NSNull) {
            description = ""
        }
        
        else {
            description = data["Description"] as! String
        }
        
        let activitiesArray = data["Activities"] as! [[String:Any]]
        
        if(!(data["Activities"] is NSNull) || !activitiesArray.isEmpty) {
            
            for object in activitiesArray {
                
                if(!object.isEmpty) {
                    tasks.append(ComponentTaskResult(withData: object))
                }
                else {
                    let component = data["Component"] as! [String:Any]
                    let activities = component["Activities"] as! [[String:Any]]
                    
                    if(!activities.isEmpty) {
                        for activity in activities {
                            if(!activity.isEmpty) {
                                tasks.append(ComponentTaskResult(withData: activity))
                            }
                            else {
                                print("No activities/tasks.")
                            }
                        }
                    }
                }
            }
        }
        
        else {
            let component = data["Component"] as! [String:Any]
            let activities = component["Activities"] as! [[String:Any]]
            
            if(!activities.isEmpty) {
                for activity in activities {
                    if(!activity.isEmpty) {
                        tasks.append(ComponentTaskResult(withData: activity))
                    }
                    else {
                        print("No activities/tasks.")
                    }
                }
            }
        }
    
        youtubeUrl = String(describing: data["YoutubeURL"])
        
        for object in data["UsefulLinks"] as! [[String:Any]] {
            usefulLinks.append(String(describing: object["Url"]))
        }
        
        id = data["Id"] as! String
    }
}
