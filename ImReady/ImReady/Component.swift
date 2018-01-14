//
//  Component.swift
//  ImReady
//
//  Created by Inholland on 1/11/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class Component {
    var name: String = "Sport"
    var isDone: Bool = false
    var tasks = [ComponentTask]()
    
    func amountTasks() -> String{
        return String(5)
    }
    
    func doneTasks() -> String{
        return String(2)
    }
}
