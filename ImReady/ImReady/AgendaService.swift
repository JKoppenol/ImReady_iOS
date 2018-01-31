//
//  AgendaService.swift
//  ImReady
//
//  Created by Inholland on 1/3/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation
import Alamofire

class AgendaService {
    let apiClient: ApiClient = ApiClient()
    
    public func getAppointments(ofUserWithId userId: String,
                                onSuccess: @escaping (_ : [Appointment]) -> (),
                                onFailure: @escaping () -> ()) {
        apiClient.send(toRelativePath: "user/\(userId)/calendar",
                       withHttpMethod: .get,
                       onSuccessDo: { (_ data) in
                        var appointments : [Appointment] = []
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: data) as! [[String:Any]]
                            
                            for object in json {
                                let appointment = AppointmentResult(withData: object) as Appointment
                                appointments.append(appointment)
                            }
                            
                            onSuccess(appointments)
                        }
                        catch {
                            onFailure()
                        }
            },
                       onFailure: onFailure)
    }
    
    public func createAppointment(forCaregiver caregiverId: String,
                                  fromObject appointment: Appointment,
                                  onSuccess: @escaping () -> (),
                                  onFailure: @escaping () -> ()) {
        apiClient.send(toRelativePath: "user/\(caregiverId)/calendar",
            withHttpMethod: .post,
            withParameters: ["Title": appointment.clientTitle,
                             "StartDate" : appointment.startTime,
                             "EndDate" : appointment.endTime,
                             "Location" : appointment.location,
                             "Remark" : appointment.comments,
                             "ClientId" : appointment.client.id],
            withHeaders: ["Content-Type": apiClient.ContentTypeHeader, "Accept": apiClient.AcceptHeader],
            withEncoding: URLEncoding.httpBody,
            onSuccessDo: {_ in
                onSuccess()
            },
            onFailure: onFailure)

    }

}
let agendaService = AgendaService()
