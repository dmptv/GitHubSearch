//
//  File.swift
//  GitHubSearch
//
//  Created by 123 on 22.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Alamofire

class ShowDetailsViewController: UIViewController {
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var viewMoreBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var containerView: SpringView!
    
    
    var repo: GithubRepo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateView(with: "zoomIn")
        containerView.animate()
    }
    
    private func animateView(with animation: String) {
        containerView.animation = animation
        containerView.curve = "easeIn"
        containerView.duration = 0.5
    }
    
    private func populateView() {
        if let ownerAvatarURL = repo.ownerAvatarURL {
            repoImageView.setImageWith(URL(string: ownerAvatarURL)!)
        }
        
        repoName.text = repo.name
        stars.text = "\(String(describing: repo.stars!))"
        ownerName.text = repo.ownerHandle
        repoDescription.text = repo.repoDescription
    }

    @IBAction func xPressed(_ sender: UIButton) {
        animateView(with: "zoomOut")
        containerView.animateNext {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
}
























