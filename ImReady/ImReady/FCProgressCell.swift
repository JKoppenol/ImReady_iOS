//
//  FutureCanvasProgressCollectionVC.swift
//  ImReady
//
//  Created by Ralph Hink on 28/12/2017.
//  Copyright © 2017 Inholland. All rights reserved.
//
import Foundation
import UIKit

class FCProgressCell: UICollectionViewCell {
    @IBOutlet weak var blockImage: UIImageView!
    @IBOutlet weak var lblBlockName: UILabel!
    @IBOutlet weak var prgTaskProgress: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(block: Block) {
        blockImage.layer.borderWidth = 1.0
        blockImage.layer.borderColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0).cgColor
        blockImage.layer.cornerRadius = 8.0
        
        prgTaskProgress.layer.borderWidth = 1.0
        prgTaskProgress.layer.borderColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0).cgColor
        
        lblBlockName.isHidden = false
        lblBlockName.text = block.name
        blockImage.image = block.image
    }
}
