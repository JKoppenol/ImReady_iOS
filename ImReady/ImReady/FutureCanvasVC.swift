//
//  FutureCanvasViewController.swift
//  ImReady
//
//  Created by Ralph Hink on 12/12/2017.
//  Copyright © 2017 Inholland. All rights reserved.
//

import UIKit

class FutureCanvasVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    //let blockIni:[Block] = blockService.mockData()
    let items:[String] = ["1","2","3"]
    let reuseIdentifier = "cell"
    var apiClient: ApiClient = ApiClient()
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of views (cells)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // Populate views (cells)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCProgressCell
        
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
    
    //func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // handle tap events
    //}
    
    
}
