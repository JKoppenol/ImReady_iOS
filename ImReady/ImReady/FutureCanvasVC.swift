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
    let apiClient: ApiClient = ApiClient()
    var currentUser = LoggedInUser().getLoggedInUser()
    let refreshControl = UIRefreshControl()
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFutureCanvas()
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        //refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        //collectionView.refreshControl = refreshControl
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        refresh(refreshControl: refreshControl)
        print("refresh...")
    }
    
    func refresh(refreshControl:UIRefreshControl) {
        loadFutureCanvas()
        //refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                                        self.collectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeaderCollectionReusableView {
            sectionHeader.headerLabel.text = "Actieve bouwstenen"
            return sectionHeader
        }
        return UICollectionReusableView()
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
        
         if segue.identifier == "toAddBlock" {
            guard segue.identifier != nil else {return}
            let addBlock: AddBlockVC = segue.destination as! AddBlockVC
            addBlock.myFutureCanvas = self.myFutureCanvas
        }

    }
    
    @IBAction func unwindToFC(segue:UIStoryboardSegue) {
    }
    
    @IBAction func logOut() {
        createAlert(title: "Uitloggen", message: "Weet u zeker dat u wilt uitloggen?", sender: self)
    }
    
    private func createAlert(title: String!, message: String!, sender: FutureCanvasVC!) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ja", style: UIAlertActionStyle.destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            sharedInstance.currentUser = nil
            _ = loginService.logOut(isTerminated: false)
             self.performSegue(withIdentifier: "unwindSegueToLogin", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Nee", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
