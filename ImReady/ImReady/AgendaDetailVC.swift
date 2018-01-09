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
    
    var appointment: Appointment = Appointment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(sharedInstance.currentUser?.role == .Caretaker) {
            editButton.isEnabled = true
            editButton.title = "Bewerk"
        }
        
        else {
            editButton.isEnabled = false
            editButton.title = ""
            editButton.tintColor = UIColor.clear
        }
        fillLabels()
        // Do any additional setup after loading the view.
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
        
        if(sharedInstance.currentUser?.role == .Caretaker) {
            titleLabel.text = agendaItem.caretakerTitle
        }
        
        else {
            titleLabel.text = agendaItem.clientTitle
        }
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateLabel.text = dateFormatter.string(from: agendaItem.day)
        
        dateFormatter.dateFormat = "HH:mm"
        startLabel.text = dateFormatter.string(from: agendaItem.startTime)
        
        if(agendaItem.hasEndTime) {
            endLabel.text = dateFormatter.string(from: agendaItem.endTime!)
        }
        
        else {
            endLabel.text = "Geen eindtijd"
        }
        
        if(agendaItem.location != "") {
            locationLabel.text = agendaItem.location
        }
        
        else {
            locationLabel.text = "Onbekend"
        }
        
        if(agendaItem.comments != "") {
            commentsLabel.text = agendaItem.comments
        }
        
        else {
            commentsLabel.text = "Geen opmerkingen"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
