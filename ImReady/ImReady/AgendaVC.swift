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
    var currentUser = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser.id = 2
        fillDaysArray(appointments: appointments)

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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(days.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let day = days[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Day") as? AgendaDayCell {
            cell.configCell(day: day, currentUser: currentUser)
            
            return(cell)
        }
            
        else {
            return MessagesCell()
        }
    }
    
    func fillDaysArray(appointments: [Appointment]) {
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

}
