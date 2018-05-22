//
//  ClosedRangeExtension.swift
//  GitHubSearch
//
//  Created by 123 on 22.05.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

extension ClosedRange {
    func clamp(_ value: Bound) -> Bound {
        if value < lowerBound {
            return lowerBound
        } else if value > upperBound {
            return upperBound
        }
        return value
    }
}

