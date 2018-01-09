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
    
    
    // MARK: - UICollectionViewDelegate protocol
    
    //func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // handle tap events
    //}
    
    
}
