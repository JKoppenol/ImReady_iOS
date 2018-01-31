//
//  Appointment.swift
//  ImReady
//
//  Created by Inholland on 1/3/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class Appointment {
    var id: String = ""
    var clientTitle: String = ""
    var caretakerTitle: String? = ""
    var day = Date()
    var startTime = Date()
    var endTime: Date = Date()
    var location: String = ""
    var comments: String = ""
    var client: User = User()
    var caretaker: User = User()
    var kind: Kind = .Appointment
}

enum Kind: String {
    case Appointment
    case Deadline
}
