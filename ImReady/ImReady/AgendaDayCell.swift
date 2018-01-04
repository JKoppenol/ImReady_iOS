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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configCell(appointment: Appointment) {
        let dateFormatter = DateFormatter()
       
        dateFormatter.dateFormat = "HH:mm"
        
        if(appointment.kind == Kind.Appointment) {
            titleLabel.text = appointment.title
            startLabel.text = dateFormatter.string(from: appointment.startTime)
            
            if(appointment.endTime != nil) {
                dashLabel.isHidden = false
                endLabel.isHidden = false
                dashLabel.text = "-"
                endLabel.text = dateFormatter.string(from: appointment.endTime!)
            }
            
            else {
                titleLabel.text = appointment.title
                startLabel.text = "Vanaf " + dateFormatter.string(from: appointment.startTime)
                dashLabel.isHidden = true
                endLabel.isHidden = true
            }
        }
        
        else {
            titleLabel.text = "Streefdatum - " + appointment.title
            startLabel.text = "Tot " + dateFormatter.string(from: appointment.startTime)
            dashLabel.isHidden = true
            endLabel.isHidden = true
        }
    }
}
