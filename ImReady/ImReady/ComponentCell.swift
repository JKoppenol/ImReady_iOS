//
//  ComponentCell.swift
//  ImReady
//
//  Created by Inholland on 1/11/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class ComponentCell: UITableViewCell {
    
    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configCell(component: Component) {
        naamLabel.text = component.name
        toDoLabel.text = component.amountTasks()
        doneLabel.text = component.doneTasks()
    }
    
}
