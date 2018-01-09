//
//  AgendaService.swift
//  ImReady
//
//  Created by Inholland on 1/3/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class AgendaService {
    func getAppointments(byUser: User) -> [Appointment]? {
            return mockData()
    }
    
    func dateHasAppointments(date: Date, user: User) -> Bool {
        let appointments = getAppointments(byUser: user)
        
        if(appointments != nil) {
            for appointment in appointments! {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                
                let stringAppointmentDay = dateFormatter.string(from: appointment.day)
                let stringDate = dateFormatter.string(from: date)
                
                if(stringAppointmentDay == stringDate) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func mockData() -> [Appointment] {
        
        var appointments = [Appointment]()
        
        let appointment1 = Appointment()
        appointment1.clientTitle = "Afspraak met Ralph Hink"
        appointment1.caretakerTitle = "Afspraak met Jeroen Koppenol"
        appointment1.id = 1
        appointment1.day = Date()
        appointment1.startTime = Date()
        let oneHour = TimeInterval(60 * 60)
        appointment1.endTime = Date(timeIntervalSinceNow: oneHour)
        appointment1.clientId = 2
        appointment1.caretakerId = 1
        
        let appointment2 = Appointment()
        appointment2.clientTitle = "CV Maken"
        appointment2.id = 2
        let oneWeek = TimeInterval(60 * 60 * 24 * 7)
        appointment2.day = Date(timeIntervalSinceNow: oneWeek)
        appointment2.kind = .Deadline
        appointment2.clientId = 2
        appointment2.hasEndTime = false
        
        let appointment3 = Appointment()
        appointment3.clientTitle = "Afspraak met Ralph Hink"
        appointment3.caretakerTitle = "Afspraak met Jeroen Koppenol"
        appointment3.id = 3
        appointment3.day = Date()
        let intervalStart = TimeInterval(60 * 60 * 24)
        let intervalEnd = TimeInterval((60 * 60 * 24) + (60 * 60))
        appointment3.startTime = Date(timeIntervalSinceNow: intervalStart)
        appointment3.endTime = Date(timeIntervalSinceNow: intervalEnd)
        appointment3.kind = .Appointment
        appointment3.clientId = 2
        appointment3.caretakerId = 1

        
        appointments.append(appointment1)
        appointments.append(appointment2)
        appointments.append(appointment3)
        
        return appointments
    }
}
let agendaService = AgendaService()
