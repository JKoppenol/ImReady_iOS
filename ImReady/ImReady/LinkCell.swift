//
//  LinkCell.swift
//  ImReady
//
//  Created by Inholland on 1/15/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class LinkCell: UITableViewCell {
    
    @IBOutlet weak var linkTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(link: String) {
        linkTextView.text = "https://nu.nl/"
    }
}
