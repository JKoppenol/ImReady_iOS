//
//  MessageResult.swift
//  ImReady
//
//  Created by Inholland on 1/17/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class MessageResult : Message {
    init(withData data: [String:Any]) {
        super.init()
        content = data["Content"] as! String
        date = formatDate(fromString: data["SentDate"] as! String, withFormat: "dd-MM-yyyy HH:mm")
        senderId = data["SenderId"] as! String
        id = data["Id"] as! String
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
