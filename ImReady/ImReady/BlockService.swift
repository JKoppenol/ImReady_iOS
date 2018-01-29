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
  
    var user: LoggedInUser = LoggedInUser().getLoggedInUser()
    
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
                        let blocks = json["Blocks"] as! [[String:Any]]
                        
                        for block in blocks{
                            let newBlock = BlockResult(withData: block) as Block
                            futureCanvas.blocks.append(newBlock)
                        }
                        onSuccess(futureCanvas)
                    }
                } catch {
                    onFailure()
                }
            },
            onFailure: onFailure)
        
    }
    
    public func getGenericBlocks(onSuccess: @escaping (_ : [GenericBlock]) -> (),
                                  onFailure: @escaping () -> ()) {
        apiClient.send(toRelativePath: "buildingblock",
                       withHttpMethod: .get,
                       onSuccessDo: {(_ data) in
                        var genericBlocks : [GenericBlock] = []
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: data) as! [[String:Any]]
                            
                            for object in json {
                                let genericBlock = GenericBlockResult(withData: object) as GenericBlock
                                genericBlocks.append(genericBlock)
                            }
                            
                            onSuccess(genericBlocks)
                        }
                        catch {
                            onFailure()
                        }
        },
                       onFailure: onFailure)
    }
    
    public func addBlockToFC(forClient client: String,
                             addBlock block: String,
                             onSuccess: @escaping () -> (),
                             onFailure: @escaping () -> ()) {
        apiClient.send(toRelativePath: "client/\(client)/futureplan/enroll/\(block)",
                       withHttpMethod: .post,
                       withParameters: ["id": client, "buildingBlockId": block],
                       withHeaders: ["Content-Type": apiClient.ContentTypeHeader, "Accept": apiClient.AcceptHeader],
                       onSuccessDo: {(_ data) in
                            onSuccess()
        },
                       onFailure: onFailure)
    }
    
    //Work in Progress - Update Taskstatus:Int with Comment/Content:String
//    public func updateTask(forClient clientId: String,
//                               forTask task: ComponentTask,
//                                   onSuccess: @escaping () -> (),
//                                   onFailure: @escaping () -> ()) {
//        var body: [String:Any] = [:]
//        
//        apiClient.send(toRelativePath: "client/\(clientId)/activity/\(task.id)",
//                       withHttpMethod: .put,
//                       withBody: body,
//                       withHeaders: ["Content-Type": apiClient.ContentTypeHeader, "Accept": apiClient.AcceptHeader],
//                       onSuccessDo: {(_ data) in
//                            onSuccess()
//                       },
//                       onFailure: onFailure)
//    }

}

let blockService = BlockService()
