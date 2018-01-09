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
    
    func configCell() {
        blockImage.layer.borderWidth = 1.0
        blockImage.layer.borderColor = UIColor.black.cgColor
        blockImage.layer.cornerRadius = 8.0
    }
}
