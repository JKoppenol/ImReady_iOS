//
//  AddAgendaVC.swift
//  ImReady
//
//  Created by Inholland on 1/2/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class AddAgendaVC: UIViewController {
    
    @IBOutlet weak var commentsTV: UITextView!
    
    @IBOutlet weak var titleTextfield: UITextField!
    
    @IBOutlet weak var dayPicker: UIDatePicker!
    
    @IBOutlet weak var startPicker: UIDatePicker!
    
    @IBOutlet weak var endLabel: UILabel!
    
    @IBOutlet weak var endPicker: UIDatePicker!
    
    @IBOutlet weak var endSwitch: UISwitch!
    
    @IBOutlet weak var locationTextfield: UITextField!
    
    var appointment = Appointment()
    
    var agendaVC: AgendaVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTV.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        commentsTV.layer.borderWidth = 1.0
        commentsTV.layer.cornerRadius = 8.0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAppointment(_ sender: UIBarButtonItem) {
        
        appointment.id = 4
        appointment.title = titleTextfield.text!
        appointment.day = dayPicker.date
        appointment.startTime = startPicker.date
        
        if(!endSwitch.isOn) {
            appointment.endTime = endPicker.date
        }
        
        if(locationTextfield.text != "") {
            appointment.location = locationTextfield.text!
        }
        
        if(commentsTV.text != "") {
            appointment.comments = commentsTV.text!
        }
        
        appointment.kind = Kind.Appointment
        
        agendaVC?.onUserAction(appointment: appointment)
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func endTimeSwitch(_ sender: UISwitch) {
        if(sender.isOn) {
            endLabel.isHidden = true
            endPicker.isHidden = true
        }
        
        else {
            endLabel.isHidden = false
            endPicker.isHidden = false
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
