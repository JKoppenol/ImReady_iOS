//
//  GenericBlockCell.swift
//  ImReady
//
//  Created by Inholland on 1/16/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class GenericBlockCell: UICollectionViewCell {
    @IBOutlet weak var blockImage: UIImageView!
    @IBOutlet weak var lblBlockName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(block: GenericBlock) {
        blockImage.layer.borderWidth = 1.0
        blockImage.layer.borderColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0).cgColor
        blockImage.layer.cornerRadius = 8.0
        
        lblBlockName.isHidden = false
        lblBlockName.text = block.name
        blockImage.image = block.image
    }
}
