//
//  ComponentInfoVC.swift
//  ImReady
//
//  Created by Inholland on 1/12/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class ComponentInfoVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var wv: UIWebView!
    @IBOutlet weak var tableView: UITableView!
    
    var links: [String] = []

    var component = Component()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadYoutube(videoID: "HiLn2yrM1GM")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func loadYoutube(videoID:String) {
        guard
            let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)")
            else { return }
        
        wv.loadRequest( URLRequest(url: youtubeURL) )
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let link = links[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Hyperlink") as? LinkCell {
            cell.configCell(link: link)
            
            return(cell)
        }
            
        else {
            return LinkCell()
        }
    }
}
