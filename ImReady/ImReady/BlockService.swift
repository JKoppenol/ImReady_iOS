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
    let apiClient: ApiClient = ApiClient()
    
//    func mockData() -> [Block] {
//        var activeblocks = [Block]()
//        
//        let block1 = Block()
//        block1.id = 1
//        block1.name = "Zorg"
//        block1.iscomplete = false
//        let component = Component()
//        component.name = "Sporten"
//        block1.components.append(component)
//        
//        let block2 = Block()
//        block2.id = 2
//        block2.name = "Sociaal"
//        block2.iscomplete = false
//        
//        let block3 = Block()
//        block3.id = 3
//        block3.name = "Financien"
//        block3.iscomplete = false
//        
//        let block4 = Block()
//        block4.id = 4
//        block4.name = "Opleiding"
//        block4.iscomplete = false
//        
//        activeblocks.append(block1)
//        activeblocks.append(block2)
//        activeblocks.append(block3)
//        activeblocks.append(block4)
//        
//        return activeblocks
//    }
    var user = LoggedInUser.currentuser.id
    
    public func getFutureCanvas(ofUserWithId userId: String,
                                onSuccess: @escaping (_ : FutureCanvas) -> (),
                                onFailure: @escaping () -> ()) {
        
        apiClient.send(toRelativePath: "client/\(userId)/futureplan",
            withHttpMethod: .get,
            onSuccessDo: { (_ data) in
                
                let futureCanvas : FutureCanvas = FutureCanvas()
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                    if let error = json["error-description"] as? String {
                        print(error)
                        onFailure()
                    }
                    else {
                        futureCanvas.blocks = json["Blocks"] as! [BlockResult]
                        onSuccess(futureCanvas)
                    }
                } catch {
                    onFailure()
                }
            },
            onFailure: onFailure)
        
    }
}

let blockService = BlockService()
