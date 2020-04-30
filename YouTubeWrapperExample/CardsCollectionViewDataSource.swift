//
//  CardsCollectionViewDelegate.swift
//  LearningCards
//
//  Created by Shai Ariman on 23/04/2020.
//  Copyright © 2020 Shai Ariman. All rights reserved.
//

import UIKit
import YouTubeSearchWrapper

class CardsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var isRegisteredCells = false
    
    private var youTubeVideoInfo : [YouTubeVideoInfo]?
    
    public var requestImage : (String)->()
    
    init(requestImage : @escaping (String)->()) {
        self.requestImage = requestImage
    }
    
    func setData(youTubeVideoInfo : [YouTubeVideoInfo]) {
        self.youTubeVideoInfo = youTubeVideoInfo
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return youTubeVideoInfo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let youTubeVideoInfo = youTubeVideoInfo {
            
            if !isRegisteredCells {
                
                collectionView.register(cellType: CardCollectionViewCell.self)
                
                isRegisteredCells.toggle()
            }
            
            let cell = collectionView.dequeueReusableCell(with: CardCollectionViewCell.self, for: indexPath)
            
            cell.setTitle(youTubeVideoInfo[indexPath.row].title)
            
            let thumbnailUrl = youTubeVideoInfo[indexPath.row].thumbnainUrl
            cell.setThumbnail(fromUrl: thumbnailUrl)
            requestImage(thumbnailUrl)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

