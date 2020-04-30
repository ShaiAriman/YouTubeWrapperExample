//
//  CardsCollectionViewDelegate.swift
//  LearningCards
//
//  Created by Shai Ariman on 23/04/2020.
//  Copyright © 2020 Shai Ariman. All rights reserved.
//

import UIKit

class CardsCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
      
    let onVideoTapped : (Int)->()
    
    init(onVideoTapped : @escaping (Int)->()) {
        self.onVideoTapped = onVideoTapped
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onVideoTapped(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.bounds.height)
    }
}

