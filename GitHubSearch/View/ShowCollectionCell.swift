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

         This is what i think it's happening:
 
 Cell A appears
 Request for image A is made to load on Cell A
 Cell A disappears from screen
 Cell A reappears (is reused)
 Request for image B is made to load on Cell A
 Request for image A is complete
 Image A loads on to the Cell A
 Request for image B is complete
 Image B loads on to the Cell A
 */

class CustomCollectionViewCell: UICollectionViewCell {
    var urlString = ""
}

/*
 let blank = UIImage(named: "blank.png")
 
func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
    
    let image = images[indexPath.row]
 
    if let imageView = cell.viewWithTag(5) as? UIImageView {
 
        imageView.image = blank
 
        cell.urlString = image.url.absoluteString
 
        if let cachedImage = cache.objectForKey(image.url) as? UIImage {
            imageView.image = cachedImage
        } else {
            UIImage.asyncDownloadImageWithUrl(image.url, completionBlock: { (succeded, dimage) -> Void in
                if succeded {
 
                    self.cache.setObject(dimage!, forKey: image.url)
                    //
                    // This can happen after the cell has dissapeared and reused!
                    // check that the image.url matches what is supposed to be in the cell at that time !!!
                    //
                    if cell.urlString == image.url.absoluteString {
                        imageView.image = dimage
                    }
                    
                }
            })
        }
    }
    
    return cell
}
*/


 
 
 
 
 
 
 
 
 







