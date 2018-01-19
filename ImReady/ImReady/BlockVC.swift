//
//  BlockVC.swift
//  ImReady
//
//  Created by Ralph Hink on 02/01/2018.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class BlockVC: UIViewController,UITabBarDelegate, UITableViewDataSource {
    var block: Block = Block()
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var blockImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        descriptionLabel.text = block.description
        blockImageView.image = block.image
        navigationItem.title = block.name
        navigationController?.navigationBar.tintColor = UIColor(red:0.24, green:0.73, blue:0.61, alpha:1.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComponentDetail" {
            guard segue.identifier != nil else {return}
            
            if let indexPath = tableView?.indexPath(for: sender as! ComponentCell) {
                let componentVC: ComponentVC = segue.destination as! ComponentVC
                componentVC.component = block.components[indexPath.row]
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = block.components[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell") as? ComponentCell {
            cell.configCell(component: component)
            
            return(cell)
        }
            
        else {
            return ComponentCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return block.components.count
    }
    
}
