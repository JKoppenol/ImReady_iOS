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
    
    func mockData() -> [Appointment]{
        var appointments = [Appointment]()
        
        let appointment1 = Appointment()
        appointment1.title = "Afspraak met Jaap de Boer (Zorgverlener)"
        appointment1.id = 1
        appointment1.day = Date()
        
        let appointment2 = Appointment()
        appointment2.title = "Poelejak met jootje"
        appointment2.id = 2
        let oneDay = TimeInterval(60 * 60 * 24)
        appointment2.day = Date(timeIntervalSinceNow: oneDay)
        
        appointments.append(appointment1)
        appointments.append(appointment2)
        
        return appointments
    }
}
let agendaService = AgendaService()
