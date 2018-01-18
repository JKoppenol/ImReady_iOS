//
//  MessageVC.swift
//  ImReady
//
//  Created by Inholland on 12/13/17.
//  Copyright © 2017 Inholland. All rights reserved.
//

import UIKit

class MessageVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var messageId: String!
    var message: Message!
    var messages: [Message] = []
    var recipient = User()
    var currentUser = LoggedInUser().getLoggedInUser()
    var chats : [Chat] = []
    var chat = Chat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        sendButton.layer.cornerRadius = 5.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(messages.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Message") as? MessagesCell {
            cell.configCell(message: message)
            
            return(cell)
        }
        
        else {
            return MessagesCell()
        }
    }
    
    private func loadData() {
        chatService.getChats(ofUserWithId: currentUser.id!,
                             onSuccess: { (chats) in
                                self.chats = chats
                                self.tableView.reloadData()
                                deactivateIndicator_Activity()
            },
                             onFailure: {
                                print("Could not find Chats from user.")
                                deactivateIndicator_Activity()
        })
        
        if(currentUser.user_type == .Client) {
            messages = chats[0].messages
        }
    }
    
    @IBAction func sendMessage(sender: UIButton) {
        message = Message()
        
        if(textField.text != "") {
            message.content = textField.text!
            message.senderId = currentUser.id!

            messages.append(message)
            textField.text = ""
            tableView.reloadData()
        }
    }
}
