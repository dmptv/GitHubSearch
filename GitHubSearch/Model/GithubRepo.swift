//
//  GithubRepo.swift
//  GitHubSearch
//
//  Created by 123 on 21.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import AFNetworking

typealias Json = [String: Any]

class GithubRepo: CustomStringConvertible {
    var name: String?
    var ownerHandle: String?
    var ownerAvatarURL: String?
    var stars: Int?
    var forks: Int?
    var repoDescription: String?
    
    init() {
        self.name = "Smith"
        self.stars = 9
        self.ownerHandle = "Stive"
        self.ownerAvatarURL = "https://avatars1.githubusercontent.com/u/169110?s=400&v=4"
    }

    init?(jsonResult: Json) {
        guard let name = jsonResult["name"] as? String,
            let stars = jsonResult["stargazers_count"] as? Int?,
            let forks = jsonResult["forks_count"] as? Int?,
            let owner = jsonResult["owner"] as? Json,
            let repoDescription = jsonResult["description"] as? String
            else { return nil }
        
        self.name = name
        self.stars = stars
        self.forks = forks
        if let ownerHandle = owner["login"] as? String {
            self.ownerHandle = ownerHandle
        }
        if let ownerAvatarURL = owner["avatar_url"] as? String {
            self.ownerAvatarURL = ownerAvatarURL
        }
        self.repoDescription = repoDescription
    }

    
    var description: String {
        return "[Name: \(self.name!)]" +
            "\n\t[Stars: \(self.stars!)]" +
            "\n\t[Forks: \(self.forks!)]" +
            "\n\t[Owner: \(self.ownerHandle!)]" +
            "\n\t[Avatar: \(self.ownerAvatarURL!)]" +
        "\n\t[Description: \(self.repoDescription!)]"
    }
}










