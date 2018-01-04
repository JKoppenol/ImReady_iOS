//
//  AgendaVC.swift
//  ImReady
//
//  Created by Inholland on 1/2/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class AgendaVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var appointments = agendaService.mockData()
    var days = [Date]()
    var sections = [AgendaDay]()
    var currentUser = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser.id = 2
        fillDaysArray()
        fillSectionsArray()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItem(_ sender: AnyObject) {
        performSegue(withIdentifier: "toAddAgendaItem", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let day = sections[indexPath.section]
        let appointment = day.appointments[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Appointment") as? AgendaDayCell {
            cell.configCell(appointment: appointment, currentUser: currentUser)
            
            return(cell)
        }
            
        else {
            return MessagesCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].appointments.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].dayName
    }
    
    func fillDaysArray() {
        for appointment in appointments {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let appointmentDay = dateFormatter.date(from: dateFormatter.string(from: appointment.day))
            
            if(!days.contains(appointmentDay!)) {
                days.append(appointmentDay!)
            }
        }
        
        if(days.count > 1) {
            days.sort { (date1, date2) -> Bool in
                return date1.compare(date2) == ComparisonResult.orderedAscending
            }
        }
    }
    
    func fillSectionsArray() {
        for day in days {
            var tempAgendaDay = AgendaDay()
            for appointment in appointments {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let appointmentDay = dateFormatter.string(from: appointment.day)
                let dateString = dateFormatter.string(from: day)
                
                dateFormatter.dateFormat = "EEEE"
                dateFormatter.locale = Locale(identifier: "nl_NL")
                let dayName = dateFormatter.string(from: day).capitalized + ", " + dateString
                
                if (appointmentDay == dateString) {
                    tempAgendaDay.dayName = dayName
                    tempAgendaDay.appointments.append(appointment)
                }
            }
            sections.append(tempAgendaDay)
        }
    }

}
