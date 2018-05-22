//
//  Globals.swift
//  GitHubSearch
//
//  Created by 123 on 22.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class Global {
    class func bannerView() {
        if let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate? {
            // check if iPhone X = 50
            let rect = UIScreen.main.bounds
            var bannerHeight: CGFloat = 20.0
            if (rect.width == 375 && rect.height == 812) {
                bannerHeight = 45
            }
            
            if let window: UIWindow = applicationDelegate.window {
                let blueView = UIView(frame: CGRect(x: UIScreen.main.bounds.minX,
                                                    y: UIScreen.main.bounds.minY,
                                                    width: UIScreen.main.bounds.width,
                                                    height: bannerHeight))
                blueView.backgroundColor = .mainBlue()
                window.addSubview(blueView)
            }
        }
    }
    
    class func transform(cell: UICollectionViewCell, view: UIView, collectionView: UICollectionView) {
        let coverFrame = cell.convert(cell.bounds, to: view)
        
        let transformOffsetY = collectionView.bounds.height * 2 / 3
        let percent = (0...1).clamp((coverFrame.minY - transformOffsetY) / (collectionView.bounds.height-transformOffsetY))
        
        let maxScaleDifference: CGFloat = 0.2
        let scale = percent * maxScaleDifference
        
        cell.transform = CGAffineTransform(scaleX: 1-scale, y: 1-scale)
    }

    
}























