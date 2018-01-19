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
        name = data["Name"] as! String
        if(!(data["Description"] is NSNull)) {
            description = data["Description"] as! String
        }
        else { description = "" }
        
        if(data["Deadline"] == nil || data["Deadline"] is NSNull) { deadline = Date() }
        else {
            deadline = formatDate(fromString: data["Deadline"] as! String, withFormat: "dd-MM-yyyy HH:mm")
        }
        
        if(data["Status"] == nil || data["Status"] is NSNull) { status = 0 }
        else { status = data["Status"] as! Int }
        
        id = data["Id"] as! String
        
        //feedback = data["Feedback"] as! String
    }
    
    private func formatDate(fromString string: String, withFormat format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var dateString = string.replacingOccurrences(of: "T", with: " ")
        
        if let dotRange = dateString.range(of: ".") {
            dateString.removeSubrange(dotRange.lowerBound..<dateString.endIndex)
        }
        
        var date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = format
        dateString = dateFormatter.string(from: date!)
        
        date = dateFormatter.date(from: dateString)
        
        return date!
    }
}
