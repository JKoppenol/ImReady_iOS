//
//  Appointment.swift
//  ImReady
//
//  Created by Inholland on 1/3/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class Appointment {
    var id: Int = 0
    var clientTitle: String = ""
    var caretakerTitle: String? = ""
    var day = Date()
    var startTime = Date()
    var endTime: Date?
    var location: String = ""
    var comments: String = ""
    var clientId: Int = 0
    var caretakerId: Int? = 0
    var kind: Kind = .Appointment
    var hasEndTime: Bool = true
}

enum Kind: String {
    case Appointment
    case Deadline
}
