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
        blockImage.layer.borderColor = UIColor.black.cgColor
        blockImage.layer.cornerRadius = 8.0
        
        lblBlockName.isHidden = false
        lblBlockName.text = block.name
        blockImage.image = block.image
    }
}
