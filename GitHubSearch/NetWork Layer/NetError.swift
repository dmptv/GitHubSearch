//
//  NetworkingError.swift
//  GitHubSearch
//
//  Created by 123 on 21.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case badNetworkingStuff
    case missingBaseURL
    case invalidResponse
}

let NetworkErrorNotification = Notification.Name(rawValue:"NetworkErrorNotification")

func networkError(_ error: Error) {
    printMine("*** error: \(error)")
    NotificationCenter.default.post(name: NetworkErrorNotification, object: nil)
}

















