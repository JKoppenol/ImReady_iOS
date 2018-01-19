//
//  BlockResult.swift
//  ImReady
//
//  Created by Inholland on 1/16/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation
import UIKit

class BlockResult : Block {
    init(withData data:[String:Any]) {
        super.init()
        name = data["Name"] as! String
        description = data["Description"] as! String
        
        for object in data["Components"] as! [[String:Any]] {
            components.append(ComponentResult(withData: object) as Component)
        }
        
        id = data["Id"] as! String
        
        image = UIImage(named: name)!
    }
}
