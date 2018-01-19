//
//  TaskCell.swift
//  ImReady
//
//  Created by Inholland on 1/15/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var readyButton: UIButton!
    
    var task: ComponentTask = ComponentTask()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        readyButton.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(task: ComponentTask) {
        self.task = task
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        statusLabel.text = checkStatus(withNumber: task.status)
        titleLabel.text = task.name
        statusLabel.text = task.getStatusText()
        descriptionLabel.text = task.description
        deadlineLabel.text = dateFormatter.string(from: task.deadline)
        
        if(task.status == 1) {
            readyButton.isEnabled = false
            readyButton.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)
        }
        
        if(task.status == 2) {
            readyButton.isHidden = true
        }
    }
    
    private func checkStatus(withNumber number: Int) -> String {
        switch number {
        case 0 : return ""
        case 1 : return "Wachten op goedkeuring."
        case 2 : return "Ready!"
        default: return ""
        }
    }
    
    @IBAction func setReady() {
        if(task.status == 0) {
            readyButton.isEnabled = false
            task.status = 1
            statusLabel.text = checkStatus(withNumber: task.status)
            readyButton.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)
        }
    }
}
