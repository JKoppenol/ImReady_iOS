//
//  EditAgendaItemVC.swift
//  ImReady
//
//  Created by Inholland on 1/9/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class EditAgendaItemVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var appointment: Appointment = Appointment()
    
    @IBOutlet weak var dayPicker: UIDatePicker!
    @IBOutlet weak var endSwitch: UISwitch!
    @IBOutlet weak var commentsTV: UITextView!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var endPicker: UIDatePicker!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var clientPicker: UIPickerView!
    
    var clients = userService.getAllUsers()
    var selectedClient = User()
    var agendaVC: AgendaVC?
    var detailVC: AgendaDetailVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clientPicker.dataSource = self;
        self.clientPicker.delegate = self;
        
        selectedClient = appointment.client
        fillUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fillUI() {
        let clientRow: Int = selectRowForClient()
        clientPicker.selectRow(clientRow, inComponent: 0, animated: false)
        dayPicker.date = appointment.day
        startPicker.date = appointment.startTime
        
        endPicker.date = appointment.endTime
        
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
    
    @IBAction func saveAppointment(_ sender: UIBarButtonItem) {
        appointment.clientTitle = "Afspraak met " + (sharedInstance.currentUser?.name)!
        appointment.client = selectedClient
        appointment.caretakerTitle = "Afspraak met " + selectedClient.name
        appointment.day = dayPicker.date
        appointment.startTime = startPicker.date
        
        appointment.endTime = endPicker.date
        
        if(locationTextfield.text != "") {
            appointment.location = locationTextfield.text!
        }
        
        if(commentsTV.text != "") {
            appointment.comments = commentsTV.text!
        }
        
        agendaVC?.onEditAction(appointment: appointment)
        detailVC?.onEditAction(appointment: appointment)
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    private func selectRowForClient() -> Int {
        return clients.index(where: { (client) -> Bool in
            client.id == appointment.client.id
        })!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clients.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clients[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedClient = clients[row]
    }

}
