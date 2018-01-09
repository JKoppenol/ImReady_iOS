//
//  BlockService.swift
//  ImReady
//
//  Created by Ralph Hink on 09/01/2018.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation
import UIKit

class BlockService {
    func mockData() -> [Block] {
        var activeblocks = [Block]()
        
        let block1 = Block()
        block1.id = 1
        block1.name = "Zorg"
        block1.image = "zorg"
        block1.iscomplete = false
        
        let block2 = Block()
        block2.id = 2
        block2.name = "Sociaal"
        block2.image = "sociaal"
        block2.iscomplete = false
        
        let block3 = Block()
        block3.id = 3
        block3.name = "Financien"
        block3.image = "financien"
        block3.iscomplete = false
        
        let block4 = Block()
        block4.id = 4
        block4.name = "Opleiding"
        block4.image = "opleiding"
        block4.iscomplete = false
        
        activeblocks.append(block1)
        activeblocks.append(block2)
        activeblocks.append(block3)
        activeblocks.append(block4)
        
        return activeblocks
    }
}
let blockService = BlockService()
