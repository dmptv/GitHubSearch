//
//  ShowCollectionCell.swift
//  GitHubSearch
//
//  Created by 123 on 22.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class ShowCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var starsLabel: UILabel!
    
    var repo: GithubRepo? {
        didSet{
            if let repo = repo {
                starsLabel.text = "\(repo.stars!)"
                
                if let ownerAvatarURL = repo.ownerAvatarURL {
                    ownerImage.downloadImage(from: ownerAvatarURL)
                }
            }
        }
    }
    
}
