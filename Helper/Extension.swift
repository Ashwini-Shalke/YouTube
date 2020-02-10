//
//  Extension.swift
//  Youtube
//
//  Created by Ashwini shalke on 10/02/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgbColor(red : CGFloat, green : CGFloat, blue : CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintswithFormat(format: String, views: UIView...){
        var viewDict = [String: UIView]()
        for (index, item) in views.enumerated(){
            let key = "v\(index)"
            viewDict[key] = item
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:format, options:[], metrics: nil, views: viewDict))
    }
}

