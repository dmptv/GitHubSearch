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
    @IBOutlet weak var starMark: UIImageView!
    
    @IBOutlet weak var loadMoreLbl: UILabel!
    
    private var urlString = ""
    private var downloadTask: DataRequest?
    private var imageViewTmp = UIImageView()
    
    var repo: GithubRepo? {
        didSet{
            if let repo = repo {
                starsLabel.text = "\(repo.stars!)"
                
                downloadTask = imageViewTmp.downloadImage(from: repo.ownerAvatarURL!)
                
                //FIXME: - images not loading upon first page
                if urlString == "" || urlString == repo.ownerAvatarURL! {
                    if let img = ownerImage {
                        img.image = nil
                    }
                    ownerImage.image = imageViewTmp.image
                }
            }
        }
    }
    
    func reversViews(isLastItem: Bool) {
        ownerImage.isHidden = isLastItem
        starsLabel.isHidden = isLastItem
        starMark.isHidden = isLastItem
        
        loadMoreLbl.isHidden = !isLastItem
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
}


class CustomCollectionViewCell: UICollectionViewCell {
    var urlString = ""
}




 
 
 
 
 
 
 
 
 







