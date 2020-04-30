//
//  CardCollectionViewCell.swift
//  LearningCards
//
//  Created by Shai Ariman on 25/04/2020.
//  Copyright © 2020 Shai Ariman. All rights reserved.
//

import UIKit
import MyExtensions

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var cardBackgroundView: UIView!

    @IBOutlet weak var backgroundLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundTrailingConstraint: NSLayoutConstraint!
    
    private var thumbnailUrl : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardBackgroundView.backgroundColor = .secondarySystemBackground
        cardBackgroundView.cornerRadius = 15
        thumbnailImageView.cornerRadius = 3
    }
    
    public func setTitle(_ title : String) {
        titleLabel.text = title
    }
    
    public func setThumbnail(fromUrl imageUrlString : String) {
        if thumbnailUrl == nil ||
            thumbnailUrl != imageUrlString {
            
            thumbnailUrl = imageUrlString
            
            NotificationCenter.default.addObserver(self, selector: #selector(onImageArrived), name: .onImageArrived, object: nil)
        }
    }
    
    private func setThumbnailImage(_ imege : UIImage?) {
        DispatchQueue.main.async {
            self.thumbnailImageView.image = imege
        }
    }
    
    @objc private func onImageArrived(_ notification : Notification) {
        if let url = notification.userInfo?[Notification.userInfoKey.url] as? String,
            url == thumbnailUrl,
            let thumbnailImage = notification.userInfo?[Notification.userInfoKey.image] as? UIImage {
            setThumbnailImage(thumbnailImage)
            NotificationCenter.default.removeObserver(self, name: .onImageArrived , object: nil)
        }
    }
    
    override func prepareForReuse() {
        thumbnailUrl = nil
        setThumbnailImage(nil)
    }
}
