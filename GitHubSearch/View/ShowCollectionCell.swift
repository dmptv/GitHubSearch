//
//  ShowCollectionCell.swift
//  GitHubSearch
//
//  Created by 123 on 22.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Alamofire

class ShowCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var starsLabel: UILabel!
    
    var urlString = ""
    fileprivate var downloadTask: DataRequest?
    var imageViewTmp = UIImageView()
    
    var repo: GithubRepo? {
        didSet{
            if let repo = repo {
                starsLabel.text = "\(repo.stars!)"
                
                downloadTask = imageViewTmp.downloadImage(from: repo.ownerAvatarURL!)
                
                if urlString == "" || urlString == repo.ownerAvatarURL! {
                    if let img = ownerImage {
                        img.image = nil
                    }
                    ownerImage.image = imageViewTmp.image
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        downloadTask?.cancel()
//        downloadTask = nil
    }
    
}


class CustomCollectionViewCell: UICollectionViewCell {
    var urlString = ""
}




 
 
 
 
 
 
 
 
 







