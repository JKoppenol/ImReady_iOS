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
    @IBOutlet weak var noAppointmentsLabel: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var appointments = agendaService.mockData()
    var days = [Date]()
    var sections = [AgendaDay]()
    var currentUser = User()
    var weekInterval = 0
    var weekNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser.id = 2
        loadData()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0

        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        days = [Date]()
        fillDaysArray()
        sections = [AgendaDay]()
        fillSectionsArray()
        
        let vc = AddAgendaVC(nibName: "AddAgendaVC", bundle: nil)
        vc.agendaVC = self
        
        let calendar = Calendar.current
        weekNumber = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: TimeInterval(weekInterval)))
        
        navItem.title = "Week " + String(weekNumber)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItem(_ sender: AnyObject) {
        performSegue(withIdentifier: "toAddAgendaItem", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {return}
        
        if(id == "toAddAgendaItem") {
            guard let destination = segue.destination as? AddAgendaVC else {return}
            
            destination.agendaVC = self
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let day = sections[indexPath.section]
        let appointment = day.appointments[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Appointment") as? AgendaDayCell {
            cell.configCell(appointment: appointment)
            
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor(red:0.24, green:0.73, blue:0.61, alpha:1.0)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
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
        
        let dateFormatter = DateFormatter()
        
        for day in days {
            var tempAgendaDay = AgendaDay()
            for appointment in appointments {
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
            
            //Set to 0:00 today
            var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            comp.timeZone = TimeZone(abbreviation: "UTC")!
            let today = Calendar.current.date(from: comp)!
            
            //Set to 0:00 same day
            comp  = Calendar.current.dateComponents([.year, .month, .day], from: day)
            comp.timeZone = TimeZone(abbreviation: "UTC")!
            let tempDay = Calendar.current.date(from: comp)!
            
            let startWeek = today.addingTimeInterval(TimeInterval(weekInterval)).startOfWeek!.addingTimeInterval(TimeInterval(60 * 60))
            let endWeek = today.addingTimeInterval(TimeInterval(weekInterval)).endOfWeek!.addingTimeInterval(TimeInterval(59 * 61))
            
            if(weekInterval != 0) {
                if(tempDay == startWeek || (tempDay > startWeek && tempDay < endWeek)) {
                    sections.append(tempAgendaDay)
                }
            }
            
            else {
                if(tempDay.fallsWithinWeek(start: startWeek, end: endWeek)) {
                    sections.append(tempAgendaDay)
                }
            }
        }
        
        if(sections.isEmpty) {
            tableView.isHidden = true
            noAppointmentsLabel.isHidden = false
        }
        
        else {
            tableView.isHidden = false
            noAppointmentsLabel.isHidden = true
        }
    }
    
    @IBAction func nextWeek(sender: UIButton!) {
        weekInterval = weekInterval + (60 * 60 * 24 * 6) + ((60 * 60 * 23) + (59 * 60))
        loadData()
    }
    
    @IBAction func previousWeek(sender: UIButton!) {
        weekInterval = weekInterval - (60 * 60 * 24 * 6) - ((60 * 60 * 23) + (59 * 60))
        loadData()
    }
    
    func onUserAction(appointment: Appointment) {
        appointments.append(appointment)
        loadData()
    }

}
