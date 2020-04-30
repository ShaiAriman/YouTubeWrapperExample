//
//  ViewController.swift
//  LearningCards
//
//  Created by Shai Ariman on 23/04/2020.
//  Copyright © 2020 Shai Ariman. All rights reserved.
//

import UIKit
import YouTubeSearchWrapper

class ViewController: UIViewController {
    
    /** Get your Api key: https://console.developers.google.com/apis/credentials */
    #warning("Set your YouTube API Key here")
    private lazy var youTube = YouTube(apiKey: "")
    
    private lazy var cardsDataSource = CardsCollectionViewDataSource(requestImage : requestImage)
    private lazy var cardsDelegate = CardsCollectionViewDelegate(onVideoTapped : videoTapped)
    
    private var youTubeVideoInfos : [YouTubeVideoInfo]?
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        cardsCollectionView.dataSource = cardsDataSource
        cardsCollectionView.delegate = cardsDelegate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        youTube.getChannelVideos(channelId: "UCLBHPoY3NugnZYURxln3fKQ", maxResults: 5) { youTubeVideoInfos in
            if let youTubeVideoInfos = youTubeVideoInfos {
                self.setVideoInfoItems(youTubeVideoInfos: youTubeVideoInfos)
            }
        }
    }
    
    func setVideoInfoItems(youTubeVideoInfos : [YouTubeVideoInfo]) {
        self.youTubeVideoInfos = youTubeVideoInfos
        DispatchQueue.main.async { [weak self] in
            self?.cardsDataSource.setData(youTubeVideoInfo: youTubeVideoInfos)
            self?.cardsCollectionView.reloadData()
        }
    }
    
    func requestImage(url : String) {
        youTube.getVideoThumbnail(url: url, completion: { thumbnailUrl, data in
            if let data = data,
                let image = UIImage(data: data) {
                NotificationCenter.default.post(name: .onImageArrived, object: nil, userInfo: [Notification.userInfoKey.url : url, Notification.userInfoKey.image : image])
            }
        })
    }
    
    func videoTapped(at index : Int) {
        if let youTubeVideoInfos = youTubeVideoInfos,
            index < youTubeVideoInfos.count {
            openUrl(url: youTubeVideoInfos[index].videoUrl)
        }
    }
}
