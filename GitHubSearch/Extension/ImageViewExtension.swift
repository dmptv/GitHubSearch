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
        let downloadTask = Alamofire.request(url).downloadProgress { progress in
            //add code for progress of the image loading
            }
            .responseData { response in
                
                if response.result.error != nil {
                    if (response.result.error! as NSError).code == -999 {
                        printMine("request image cancelled")
                        return
                    } else {
                        printMine("network error")
                    }
                }
               
                if let data = response.result.value {
                    self.image = UIImage(data: data)
                }else {
                    self.image = #imageLiteral(resourceName: "No_image_available")
                }

        }
        return downloadTask
    }
}
















