//
//  GenericComponentResult.swift
//  ImReady
//
//  Created by Ralph Hink on 19/01/2018.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class GenericComponentResult : GenericComponent {
    init(withData data:[String:Any]) {
        super.init()
        components = data["Components"] as! [ComponentResult]
    }
}
