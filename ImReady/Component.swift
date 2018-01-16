//
//  Component.swift
//  ImReady
//
//  Created by Inholland on 1/11/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation

class Component {
    
    var name : String = ""
    var description : String = ""
    var tasks : [ComponentTask] = []
    var youtubeUrl : String = ""
    var usefulLinks : [String] = []
    var id : String = ""
    
    func amountTasks() -> String{
        return String(tasks.count)
    }
    
    func doneTasks() -> String{
        return String(0)
    }
}
