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
    @IBOutlet weak var toggleButton: UIButton!
    
    var task = ComponentTask()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        readyButton.layer.cornerRadius = 5.0
        statusLabel.text = ""
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(task: ComponentTask) {
        self.task = task
//        titleLabel.text
//        statusLabel.text
//        descriptionLabel.text
//        deadlineLabel.text
    }
    
    @IBAction func setReady() {
        readyButton.isEnabled = false
    }
}
