//
//  API.swift
//  GitHubSearch
//
//  Created by 123 on 21.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import Alamofire

public enum GithubRouter: URLRequestConvertible {

    enum Constants {
        static let baseURLPath = "https://api.github.com/search"
    }
    
    case search(String, Int)
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "/repositories"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .search(let searchStr, let page):
            return ["q": searchStr,
                    "sort": 0,
                    "page" : page]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        request.allHTTPHeaderFields = ["Accept": "application/vnd.github.v3+json"]
        
        return  try URLEncoding.default.encode(request, with: parameters)
    }
    
    
}




























