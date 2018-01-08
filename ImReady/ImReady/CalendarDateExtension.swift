//
//  CalendarDateExtension.swift
//  ImReady
//
//  Created by Inholland on 1/5/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}
extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 8, to: sunday)
    }
    
    func fallsWithinWeek(start: Date, end: Date) -> Bool {
        if((self > start && self < end)) {
            return true
        }
        
        return false
    }
}
