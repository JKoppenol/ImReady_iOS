//
//  Bouwsteen.swift
//  ImReady
//
//  Created by Ralph Hink on 05/12/2017.
//  Copyright © 2017 Inholland. All rights reserved.
//

import Foundation
//import UIKit

class Block {
    var id : Int = 0
    var name : String = ""
    var moduleid : Int = 0
    var goalids : [Int] = []
    //    var image: UIImage =
    var iscomplete : Bool = false
    var components = [Component]()
}
