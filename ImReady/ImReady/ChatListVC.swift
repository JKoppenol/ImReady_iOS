//
//  ChatListVC.swift
//  ImReady
//
//  Created by Inholland on 1/10/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class ChatListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var chats = [Chat]()
    let currentUser = sharedInstance.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        chats.append(chatService.mockData())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {return}
        var selectedRowIndex = self.tableView.indexPathForSelectedRow
        
        if(id == "toChat") {
            guard let destination = segue.destination as? MessageVC else {return}
            
            destination.chat = chats[(selectedRowIndex?.row)!]
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chats[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell") as? ChatCell {
            cell.configCell(chat: chat, currentUser: currentUser!)
            
            return(cell)
        }
            
        else {
            return MessagesCell()
        }    }
}
