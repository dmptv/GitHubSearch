//
//  GithubRepo.swift
//  GitHubSearch
//
//  Created by 123 on 21.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

enum State {
    case notSearchedYet
    case loading
    case noResults
    case results([GithubRepo])
}

typealias Json = [String: Any]

class GithubRepo: CustomStringConvertible {
    var name: String?
    var ownerHandle: String?
    var ownerAvatarURL: String?
    var stars: Int?
    var forks: Int?
    var repoDescription: String?
    
    init() {
        self.ownerHandle = "Elon mAsk"
        self.repoDescription = "This is Sparta"
        self.ownerAvatarURL = "https://i.stack.imgur.com/yjY1E.png?s=328&g=1"
        self.name = "Swift"
        self.stars = 456
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










