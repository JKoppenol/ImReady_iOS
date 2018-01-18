//
//  GenericBlockDetailVC.swift
//  ImReady
//
//  Created by Inholland on 1/16/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class GenericBlockDetailVC: UIViewController, UITabBarDelegate, UITableViewDataSource {

    var block : GenericBlock = GenericBlock()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.addTarget(self, action: #selector(addBlock), for: UIControlEvents.touchUpInside)
        addButton.layer.cornerRadius = 5.0
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBlock(sender: UIButton!) {
        if(block.name == "") {
            createAlert(title: "Er is iets fout gegaan!", message: "De bouwsteen kon niet worden toegevoegd, probeer het nogmaals of neem contact op met de beheerder.")
        }
        
        blockService.addBlockToFC(forClient: LoggedInUser().getLoggedInUser().id!,
                                  addBlock: block.id,
                                  onSuccess: {
                                    self.createAlert(title: "Bouwsteen toegevoegd!", message: "De bouwsteen \(self.block.name) is toegevoegd aan je toekomstplan.")
                                    //TO DO: segue naar toekomstplan
        
        },
                                  onFailure: {
                                    print("Error in adding block to future canvas")
        })
    }
    
    private func setupUI() {
        descriptionLabel.text = block.description
        imageView.image = block.image
        navigationItem.title = block.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toComponentDetail" {
//            guard segue.identifier != nil else {return}
//            
//            if let indexPath = tableView?.indexPath(for: sender as! ComponentCell) {
//                let componentVC: ComponentVC = segue.destination as! ComponentVC
//                componentVC.component = block.components[indexPath.row]
//            }
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = block.components[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GenericComponentCell") as? GenericComponentCell {
            cell.configCell(component: component)
            
            return(cell)
        }
            
        else {
            return GenericComponentCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return block.components.count
    }
    
    private func createAlert(title: String!, message: String!) {
        deactivateIndicator_Activity()
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Oke", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}
