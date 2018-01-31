//
//  AgendaDetailVC.swift
//  ImReady
//
//  Created by Inholland on 1/9/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class AgendaDetailVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var attendeesLabel: UILabel!
    
    var appointment: Appointment = Appointment()
    let currentUser = LoggedInUser().getLoggedInUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = EditAgendaItemVC(nibName: "EditAgendaItemVC", bundle: nil)
        vc.detailVC = self
        
        if(sharedInstance.currentUser?.role == Role.Caregiver) {
            editButton.isEnabled = true
            editButton.title = "Bewerk"
        }
        
        else {
            editButton.isEnabled = false
            editButton.title = ""
            editButton.tintColor = UIColor.clear
        }
        
        fillLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backBtn = UIBarButtonItem()
        backBtn.title = "Annuleren"
        navigationItem.backBarButtonItem = backBtn
        
        if(segue.identifier == "toEditAppointment") {
            if let vc = segue.destination as? EditAgendaItemVC {
                vc.appointment =  self.appointment
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillLabels() {
        let agendaItem = self.appointment
        let dateFormatter = DateFormatter()
       
        //Title
        if(sharedInstance.currentUser?.role == Role.Caregiver) {
            titleLabel.text = agendaItem.caretakerTitle
        }
        
        else {
            titleLabel.text = agendaItem.clientTitle
        }
        
        //Date
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateLabel.text = dateFormatter.string(from: agendaItem.day)
        
        //Starttime
        dateFormatter.dateFormat = "HH:mm"
        startLabel.text = dateFormatter.string(from: agendaItem.startTime)
        
        //Attendees
        self.attendeesLabel.text = "Gebruiker ophalen..."
        if(currentUser.user_type == .Client) {
            userService.getUser(withId: agendaItem.caretaker.id,
                                withRole: currentUser.user_type!,
                                onSuccess: { (user) in
                                    agendaItem.caretaker = user
                                    self.attendeesLabel.text = agendaItem.caretaker.getFullName()
                },
                                onFailure: {
                                    print("Unable to find caretaker.")
                                    self.attendeesLabel.text = "Geen"
            })
        }
        
        else {
            userService.getUser(withId: agendaItem.client.id,
                                withRole: currentUser.user_type!,
                                onSuccess: { (user) in
                                    agendaItem.client = user
                                    self.attendeesLabel.text = agendaItem.client.getFullName()
                },
                                onFailure: {
                                    print("Unable to find client.")
                                    self.attendeesLabel.text = "Geen"
            })
        }
        
        //Endtime
        endLabel.text = dateFormatter.string(from: agendaItem.endTime)
                
        //Location
        if(agendaItem.location != "") {
            locationLabel.text = agendaItem.location
        }
        
        else {
            locationLabel.text = "Onbekend"
        }
        
        //Comments
        if(agendaItem.comments != "") {
            commentsLabel.text = agendaItem.comments
        }
            
        else {
            commentsLabel.text = "Geen opmerkingen"
        }
    }
    
    func onEditAction(appointment: Appointment) {
        self.appointment = appointment
        fillLabels()
    }
}
