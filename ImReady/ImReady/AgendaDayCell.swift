//
//  AgendaDayCell.swift
//  ImReady
//
//  Created by Inholland on 12/14/17.
//  Copyright © 2017 Inholland. All rights reserved.
//

import UIKit

class AgendaDayCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configCell(day: Date, currentUser: User) {
        if(agendaService.dateHasAppointments(date: day, user: currentUser)) {
            nameLabel.text = getName(fromDay: day)
            dateLabel.text = dateToString(date: day)
        }
    }
    
    func getName(fromDay: Date) -> String! {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "nl_NL")
        
        let dateString: String = formatter.string(from: fromDay)
        
        return dateString
    }
    
    func dateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        let dateString: String = formatter.string(from: date)
        
        return dateString
    }
}
