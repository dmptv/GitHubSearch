//
//  GithubCell.swift
//  GitHubSearch
//
//  Created by 123 on 21.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import AFNetworking

class GithubCell: UITableViewCell {
    
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var starCountLabel: UILabel!
    
    
    var repo: GithubRepo! {
        didSet{
            projectLabel.text = repo.name
            authorLabel.text = "Created by "+repo.ownerHandle!
            starCountLabel.text = "\(repo.stars!)"
            
            if let ownerAvatarURL = repo.ownerAvatarURL {
                authorImageView.setImageWith(URL(string: ownerAvatarURL)!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}









