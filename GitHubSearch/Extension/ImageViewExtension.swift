//
//  ImageViewExtension.swift
//  GitHubSearch
//
//  Created by 123 on 22.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    func downloadImage(from url: String) -> DataRequest {
        let downloadTask = Alamofire.request(url)
            .downloadProgress { progress in
            //add code for progress of the image loading
            }
            .responseData { [weak self] response in
                
                if response.result.error != nil {
                    if (response.result.error! as NSError).code == -999 {
                        printMine("request image cancelled")
                        return
                    } else {
                        printMine("network error")
                    }
                }
                
                DispatchQueue.main.async {
                    // check whether “self” still exists if not,
                    // then there is no more UIImageView to set the image on
                    guard let strongSelf = self else { return }
                        if let data = response.result.value,
                            let image = UIImage(data: data) {
                            strongSelf.image = image
                        } else {
                            strongSelf.image = #imageLiteral(resourceName: "No_image_available")
                        }
                }

        }
        return downloadTask
    }
    
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url) { [weak self] url, response, error in
            if error == nil,
                let url = url,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    // check whether “self” still exists if not,
                    // then there is no more UIImageView to set the image on
                    if let strongSelf = self {
                        strongSelf.image = image
                    }
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}

























