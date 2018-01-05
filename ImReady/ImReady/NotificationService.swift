//
//  NotificationService.swift
//  ImReady
//
//  Created by Inholland on 1/5/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class NotificationService {
    func mockData() -> [Notification] {
        var notifications = [Notification]()
        
        let notification1 = Notification()
        notification1.id = 1
        notification1.title = "Welkom op I'm Ready!"
        notification1.content = "Van harte welkom! Wil jij weten hoe je het meeste uit deze app kan halen? Volg de handleiding door op deze notificatie te klikken!"
        notification1.date = Date()
        notification1.receiverId = 2
        
        let notification2 = Notification()
        notification2.id = 2
        notification2.title = "Goed bezig, je hebt een taak in Werk voltooid!"
        notification2.content = "Je zorgverlener heeft een voltooide taak goedgekeurd! Bekijk nu welke taak dit is door op deze notificatie te klikken."
        notification2.date = Date()
        notification2.receiverId = 2
        
        let notification3 = Notification()
        notification3.id = 3
        notification3.title = "Helaas, er is een taak in Gezondheid afgekeurd."
        notification3.content = "Je zorgverlener heeft een voltooide taak afgekeurd. Bekijk nu welke taak dit is en wat je kan verbeteren door op deze notificatie te klikken."
        notification3.date = Date()
        notification3.receiverId = 2
        
        notifications.append(notification1)
        notifications.append(notification2)
        notifications.append(notification3)
        
        return notifications
    }
}


let notificationService = NotificationService()

