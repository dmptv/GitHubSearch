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
    
    fileprivate var downloadTask: DataRequest?
    
    var repo: GithubRepo? {
        didSet{
            if let repo = repo {
                starsLabel.text = "\(repo.stars!)"
                
                if let ownerAvatarURL = repo.ownerAvatarURL {
                    downloadTask = ownerImage.downloadImage(from: ownerAvatarURL)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        downloadTask?.cancel()
        downloadTask = nil
    }
    
}


/*

                    // This can happen after the cell has dissapeared and reused!
                    // check that the image.url matches what is supposed to be in the cell at that time !!!
                    //
                    if cell.urlString == image.url.absoluteString {
                        imageView.image = dimage
                    }

*/


 
 
 
 
 
 
 
 
 







