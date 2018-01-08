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
    var messages = chatService.mockData().messages
    var recipient = User()
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = sharedInstance.currentUser!
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
            cell.configCell(message: message, currentUser: currentUser)
            
            return(cell)
        }
        
        else {
            return MessagesCell()
        }
    }
    
    func loadData() {
        messages = chatService.mockData().messages
    }
    
    @IBAction func sendMessage(sender: UIButton) {
        message = Message()
        
        if(textField.text != "") {
            message.id = messages.count + 1
            message.content = textField.text!
            message.senderId = currentUser.id
            message.receiverId = 1
            
            messages.append(message)
            textField.text = ""
            tableView.reloadData()
        }
    }
}
