//
//  UIView+Indicator.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/01/31.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func startIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.center
        indicator.startAnimating()
        
        let grayView = UIView(frame: self.frame)
        grayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        grayView.tag = 999
        
        grayView.addSubview(indicator)
        self.addSubview(grayView)
    }
    
    func stopIndicator() {
        self.subviews.forEach {
            if $0.tag == 999 {
                $0.removeFromSuperview()
                
                let a = $0.subviews.last as? UIActivityIndicatorView
                a?.stopAnimating()
                a?.removeFromSuperview()
            }
        }
    }
}
