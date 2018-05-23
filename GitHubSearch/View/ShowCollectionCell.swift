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
    
    @IBOutlet public weak var ownerImage: CustomImageView!
    @IBOutlet public weak var starsLabel: UILabel!
    @IBOutlet public weak var starMark: UIImageView!
    
    @IBOutlet weak var loadMoreLbl: UILabel!
    
    public var repo: GithubRepo? {
        didSet{
            if let repo = repo {
                starsLabel.text = "\(repo.stars!)"
                guard let avatarStrUrl  = repo.ownerAvatarURL else { return }
                ownerImage.loadImage(urlString: avatarStrUrl)
            }
        }
    }
    
    public func reversViews(isLastItem: Bool) {
        ownerImage.isHidden = isLastItem
        starsLabel.isHidden = isLastItem
        starMark.isHidden = isLastItem
        
        loadMoreLbl.isHidden = !isLastItem
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}




 
 
 
 
 
 
 
 
 







