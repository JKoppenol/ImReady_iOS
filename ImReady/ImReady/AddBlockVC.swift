//
//  AddBlockVC.swift
//  ImReady
//
//  Created by Inholland on 1/16/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class AddBlockVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var myFutureCanvas: FutureCanvas = FutureCanvas()
    var blocks : [GenericBlock] = []
    let reuseIdentifier = "GenericBlock"
    var activeBlocks: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGenericBlocks()
        // Do any additional setup after loading the view.
    }
    
    func createActiveBlocksArray() {
        for block in myFutureCanvas.blocks {
            activeBlocks.append(block.name)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GenericBlockCell
        
        let block: GenericBlock = blocks[indexPath.item]
        cell.configCell(block: block)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGenericBlockDetail" {
            assert(sender as? UICollectionViewCell != nil, "Sender is not a collection view")
            guard segue.identifier != nil else {return}
            
            if let indexPath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell) {
                let detailVC: GenericBlockDetailVC = segue.destination as! GenericBlockDetailVC
                detailVC.block = blocks[indexPath.row]
            }
        }
    }
    
    private func loadGenericBlocks() {
        activateIndicator_Activity(onViewController: self, onView: view)
        blockService.getGenericBlocks(onSuccess: { (genericBlocks) in
                                        self.blocks = genericBlocks
                                        var i = 0
                                        for block in self.blocks{
                                            if(self.activeBlocks.contains(block.name)){
                                                self.blocks.remove(at: i)
                                            }
                                            i += 1
                                        }
                                        self.collectionView.reloadData()
                                        deactivateIndicator_Activity()
                                        },
                                      onFailure: {
                                        print("Failed to retrieve Generic Blocks")
                                        deactivateIndicator_Activity()
                                        })
    }

}
