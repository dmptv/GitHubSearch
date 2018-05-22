//
//  NetworkingError.swift
//  GitHubSearch
//
//  Created by 123 on 21.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

enum NetError: Error {
    case badNetworkingStuff
    case missingBaseURL
    case invalidResponse
}
