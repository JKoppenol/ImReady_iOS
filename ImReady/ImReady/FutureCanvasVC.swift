//
//  FutureCanvasViewController.swift
//  ImReady
//
//  Created by Ralph Hink on 12/12/2017.
//  Copyright © 2017 Inholland. All rights reserved.
//

import UIKit

class FutureCanvasVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let blocks:[Block] = blockService.mockData()
    let reuseIdentifier = "cell"
    var apiClient: ApiClient = ApiClient()
    var currentUser: User?
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return self.blocks.count
    }
    
    // Populate views (cells)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCProgressCell
        
        let block: Block = blocks[indexPath.item]
        cell.configCell(block: block)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath as IndexPath) {
            performSegue(withIdentifier: "ShowBlockSegue", sender: cell)
        } else {
            // Error indexPath is not on screen: this should never happen.
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        assert(sender as? UICollectionViewCell != nil, "Sender is not a collection view")
        guard segue.identifier != nil else {return}
        
            if let indexPath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell) {
                if segue.identifier == "ShowBlockSegue" {
                    let blockVC: BlockVC = segue.destination as! BlockVC
                    blockVC.block = blocks[indexPath.row]
                }
             else {
                // Error sender is not a cell or cell is not in collectionView.
            }
        }
    }
    

    
    
    // MARK: - UICollectionViewDelegate protocol
    
    //func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // handle tap events
    //}
    
    
}
