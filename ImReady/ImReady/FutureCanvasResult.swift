//
//  FutureCanvasResult.swift
//  ImReady
//
//  Created by Inholland on 1/16/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class FutureCanvasResult : FutureCanvas {
    init(withData data:[String:Any]) {
        super.init()
        blocks = (data["Blocks"] as? [BlockResult])!
    }
}
