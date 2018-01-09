//
//  AgendaDayCell.swift
//  ImReady
//
//  Created by Inholland on 12/14/17.
//  Copyright © 2017 Inholland. All rights reserved.
//

import UIKit

class AgendaDayCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var dashLabel: UILabel!
    
    @IBOutlet weak var endLabel: UILabel!
    
    var appointment = Appointment()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configCell(appointment: Appointment) {
        self.appointment = appointment
        let dateFormatter = DateFormatter()
       
        dateFormatter.dateFormat = "HH:mm"
        
        if(appointment.kind == Kind.Appointment) {
            if(sharedInstance.currentUser?.role == .Client) {
                titleLabel.text = appointment.clientTitle
                
                if(appointment.endTime != nil) {
                    dashLabel.isHidden = false
                    endLabel.isHidden = false
                    dashLabel.text = "-"
                    endLabel.text = dateFormatter.string(from: appointment.endTime!)
                }
                    
                else {
                    titleLabel.text = appointment.clientTitle
                    startLabel.text = "Vanaf " + dateFormatter.string(from: appointment.startTime)
                    dashLabel.isHidden = true
                    endLabel.isHidden = true
                }

            }
                
            else {
                titleLabel.text = appointment.caretakerTitle
                
                if(appointment.endTime != nil) {
                    dashLabel.isHidden = false
                    endLabel.isHidden = false
                    dashLabel.text = "-"
                    endLabel.text = dateFormatter.string(from: appointment.endTime!)
                }
                    
                else {
                    titleLabel.text = appointment.caretakerTitle
                    startLabel.text = "Vanaf " + dateFormatter.string(from: appointment.startTime)
                    dashLabel.isHidden = true
                    endLabel.isHidden = true
                }

            }
            
            startLabel.text = dateFormatter.string(from: appointment.startTime)
            
        }
        
        else {
            titleLabel.text = "Streefdatum - " + appointment.clientTitle
            startLabel.text = "Tot " + dateFormatter.string(from: appointment.startTime)
            dashLabel.isHidden = true
            endLabel.isHidden = true
        }
    }
}
