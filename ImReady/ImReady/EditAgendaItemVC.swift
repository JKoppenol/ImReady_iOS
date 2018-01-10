//
//  EditAgendaItemVC.swift
//  ImReady
//
//  Created by Inholland on 1/9/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class EditAgendaItemVC: UIViewController {

    var appointment: Appointment = Appointment()
    
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var dayPicker: UIDatePicker!
    @IBOutlet weak var endSwitch: UISwitch!
    @IBOutlet weak var commentsTV: UITextView!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var endPicker: UIDatePicker!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fillUI() {
        titleTextfield.text = appointment.caretakerTitle
        dayPicker.date = appointment.day
        startPicker.date = appointment.startTime
        
        if(!appointment.hasEndTime) {
            endPicker.isHidden = true
            endLabel.isHidden = true
            endSwitch.isOn = true
        }
        
        else {
            endSwitch.isOn = false
            endPicker.isHidden = false
            endLabel.isHidden = false
            
            endPicker.date = appointment.endTime!
        }
        
        locationTextfield.text = appointment.location
        commentsTV.text = appointment.comments
        
        commentsTV.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        commentsTV.layer.borderWidth = 1.0
        commentsTV.layer.cornerRadius = 8.0
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
