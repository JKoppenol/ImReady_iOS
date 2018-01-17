//
//  AppointmentResult.swift
//  ImReady
//
//  Created by Inholland on 1/17/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class AppointmentResult : Appointment {
    init(withData data:[String:Any]) {
        super.init()
        id = data["Id"] as! String
        clientTitle = data["Title"] as! String
        caretakerTitle = data["Title"] as? String
        day = formatDate(fromString: data["StartDate"] as! String, withFormat: "dd-MM-yyyy")
        startTime = formatDate(fromString: data["StartDate"] as! String, withFormat: "HH:mm")
        endTime = formatDate(fromString: data["EndDate"] as! String, withFormat: "HH:mm")
        location = data["Location"] as! String
        comments = data["Remark"] as! String
        
        if(data["ClientId"] is NSNull) {
            client.id = ""
        }
        else {
            client.id = data["ClientId"] as! String
        }
        
        kind = .Appointment
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
