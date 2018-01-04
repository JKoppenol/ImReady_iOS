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
    
    func configCell(appointment: Appointment, currentUser: User) {
        
    }
}
