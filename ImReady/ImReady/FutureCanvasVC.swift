//
//  FutureCanvasViewController.swift
//  ImReady
//
//  Created by Ralph Hink on 12/12/2017.
//  Copyright © 2017 Inholland. All rights reserved.
//

import UIKit

class FutureCanvasVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var myFutureCanvas : FutureCanvas = FutureCanvas()
    let reuseIdentifier = "cell"
    var apiClient: ApiClient = ApiClient()
    var currentUser = LoggedInUser.currentuser
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFutureCanvas()
        
//    collectionView.rowHeight = UITableViewAutomaticDimension
//    collectionView.estimatedRowHeight = 125.0
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of views (cells)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myFutureCanvas.blocks.count
    }
    
    private func loadFutureCanvas() {
        activateIndicator_Activity(onViewController: self, onView: view)
        blockService.getFutureCanvas(ofUserWithId: currentUser.id!,
                                     onSuccess: { (futureCanvas) in
                                        self.myFutureCanvas = futureCanvas
                                        deactivateIndicator_Activity()
                                        },
                                     onFailure: {
                                        print("Failed to retrieve FutureCanvas.")
                                        //create alert
                                        deactivateIndicator_Activity()
                                        })
    }
    
    // Populate views (cells)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCProgressCell
        
        let block: Block = myFutureCanvas.blocks[indexPath.item]
        cell.configCell(block: block)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath as IndexPath) {
            performSegue(withIdentifier: "ShowBlockSegue", sender: cell)
        } else {
            // Error indexPath is not on screen: this should never happen.
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBlockSegue" {
            assert(sender as? UICollectionViewCell != nil, "Sender is not a collection view")
            guard segue.identifier != nil else {return}
            
            if let indexPath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell) {
                let blockVC: BlockVC = segue.destination as! BlockVC
                blockVC.block = myFutureCanvas.blocks[indexPath.row]
            }
        }
    }
    
    @IBAction func logOut() {
        createAlert(title: "Uitloggen", message: "Weet u zeker dat u wilt uitloggen?", sender: self)
    }
    
    private func createAlert(title: String!, message: String!, sender: FutureCanvasVC!) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ja", style: UIAlertActionStyle.destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            sharedInstance.currentUser = nil
            self.performSegue(withIdentifier: "logOut", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Nee", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
