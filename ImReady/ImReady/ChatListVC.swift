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
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var chats = [Chat]()
    let currentUser = LoggedInUser().getLoggedInUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadChats()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var selectedRowIndex = self.tableView.indexPathForSelectedRow
        
        if segue.identifier == "toChatDetail" {
            assert(sender as? UITableViewCell != nil, "Sender is not a tableview")
            guard segue.identifier != nil else {return}
            
            if (self.tableView?.indexPath(for: sender as! UITableViewCell)) != nil {
                let destination: MessageVC = segue.destination as! MessageVC
                destination.chat = chats[(selectedRowIndex?.row)!]
            }
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
            cell.configCell(chat: chat)
            
            return(cell)
        }
            
        else {
            return MessagesCell()
        }
    }
    
    private func loadChats() {
        activateIndicator_Activity(onViewController: self, onView: view)
        chatService.getChats(ofUserWithId: (currentUser.id)!,
                             onSuccess: { (chats) in
                                self.chats = chats
                                self.tableView.reloadData()
                                deactivateIndicator_Activity()
            }) {
                print("Could not retrieve chats.")
                deactivateIndicator_Activity()
        }
    }
}
