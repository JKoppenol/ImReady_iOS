//
//  FCSectionHeaderCollectionReusableView.swift
//  ImReady
//
//  Created by Ralph Hink on 09/01/2018.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class FCSectionHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath as IndexPath) as! FCSectionHeaderCollectionReusableView
        
        header.headerLabel.text = "Actieve bouwstenen"
        
        return header
        
    }

        
}
