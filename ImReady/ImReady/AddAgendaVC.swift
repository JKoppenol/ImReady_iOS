//
//  AddAgendaVC.swift
//  ImReady
//
//  Created by Inholland on 1/2/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class AddAgendaVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var commentsTV: UITextView!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var dayPicker: UIDatePicker!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var endPicker: UIDatePicker!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var clientPicker: UIPickerView!

    var appointment = Appointment()
    var selectedUser = User()
    var agendaVC: AgendaVC?
    var currentUser = LoggedInUser().getLoggedInUser()
    var clients: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateIndicator_Activity(onViewController: self, onView: view)
        userService.getClientsOfCaretaker(withId: currentUser.id!,
                                          onSuccess: { (users) in
                                            self.clients = users
                                            self.clientPicker.reloadAllComponents()
                                            deactivateIndicator_Activity()
            }) { 
                print("Could not retrieve clients.")
                deactivateIndicator_Activity()
        }
        
        self.clientPicker.dataSource = self;
        self.clientPicker.delegate = self;
        
        commentsTV.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        commentsTV.layer.borderWidth = 1.0
        commentsTV.layer.cornerRadius = 8.0
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "< Terug", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc private func back(sender: UIBarButtonItem) {
        createAlert(title: "Weet je het zeker?", message: "Als je de pagina verlaat worden al je ingevoerde gegevens niet opgeslagen!", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveAppointment(_ sender: UIBarButtonItem) {
        appointment.client = selectedUser
        appointment.clientTitle = titleTextfield.text!
        appointment.caretakerTitle = titleTextfield.text
        appointment.id = ""
        appointment.day = dayPicker.date
        appointment.startTime = startPicker.date
        appointment.endTime = endPicker.date
        
        userService.getUser(withId: currentUser.id!,
                            withRole: Role.Client,
                            onSuccess: { (user) in
                                self.appointment.caretaker = user
            },
                            onFailure: {print("Could not retrieve user.")}
        )
        
        if(locationTextfield.text != "") {
            appointment.location = locationTextfield.text!
        }
        
        if(commentsTV.text != "") {
            appointment.comments = commentsTV.text!
        }
        
        appointment.kind = Kind.Appointment
        
        save(appointment: appointment)
        agendaVC?.onUserAction(appointment: appointment)
        
    }
    
    private func save(appointment: Appointment) {
        activateIndicator_Activity(onViewController: self, onView: view)
        agendaService.createAppointment(forCaregiver: currentUser.id!,
                                        fromObject: appointment,
                                        onSuccess:{_ in
                                            self.agendaVC?.tableView.reloadData()
                                            deactivateIndicator_Activity()
                                            _ = self.navigationController?.popViewController(animated: true)
                                        },
                                        onFailure: {
                                            print("Could not create appointment")
                                            deactivateIndicator_Activity()
                                        })
    }
    
    private func createAlert(title: String!, message: String!, sender: AddAgendaVC!) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ja", style: UIAlertActionStyle.destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Nee", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clients.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clients[row].getFullName()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedUser = clients[row]
    }

}
