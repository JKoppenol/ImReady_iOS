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
        name = (data["Name"] as? String)!
        
        if(data["Description"] is NSNull) {
            let component = data["Component"] as? [String:Any]
            
            if(component?["Description"] is NSNull) {
                self.description = ""
            }
            
            else {
                self.description = (component?["Description"] as? String)!
            }
        }
        
        else {
            description = (data["Description"] as? String)!
        }
        
        let activitiesArray = data["Activities"] as! [[String:Any]]
        
        if(!(data["Activities"] is NSNull) || !activitiesArray.isEmpty) {
            
            for object in activitiesArray {
                
                if(!object.isEmpty) {
                    tasks.append(ComponentTaskResult(withData: object))
                }
                else {
                    let component = data["Component"] as? [String:Any]
                    let activities = component?["Activities"] as? [[String:Any]]
                    
                    if(!(activities?.isEmpty)!) {
                        for activity in activities! {
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
            let component = data["Component"] as? [String:Any]
            let activities = component?["Activities"] as? [[String:Any]]
            
            if(!(activities?.isEmpty)!) {
                for activity in activities! {
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
        
        let links = data["UsefulLinks"] as? [[String:Any]]
        
        if(links?.isEmpty)! {
            let component = data["Component"] as? [String:Any]
            let usefulLinks = component?["UsefulLinks"] as? [[String:Any]]
            
            if(!(usefulLinks?.isEmpty)!) {
                for link in usefulLinks! {
                    self.usefulLinks.append(String(describing: link["Url"]))
                }
            }
            
            else {
                self.usefulLinks = []
            }
        }
        
        else {
            for object in (data["UsefulLinks"] as? [[String:Any]])! {
                usefulLinks.append(String(describing: object["Url"]))
            }
        }
        
        if(data["YoutubeURL"] is NSNull) {
            let component = data["Component"] as? [String:Any]
            
            if(component?["YoutubeURL"] is NSNull) {
                self.youtubeUrl = ""
            }
                
            else {
                if(component?["YoutubeURL"] as? String != "") {
                    self.youtubeUrl = (component?["YoutubeURL"] as? String)!
                }
                
                else {
                    self.youtubeUrl = ""
                }
            }
        }
        
        else {
            self.youtubeUrl = (data["YoutubeURL"] as? String)!
        }
        
        id = (data["Id"] as? String)!
    }
}
