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
        components = data["Components"] as! [ComponentResult]
        id = data["Id"] as! String
        
        image = UIImage(named: name)!
    }
}
