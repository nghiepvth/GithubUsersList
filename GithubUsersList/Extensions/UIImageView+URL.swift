//
//  UIImageView+URL.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/02.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: URL?, defaultImage: UIImage = UIImage(named: "NoImage")!) {
        do {
            guard let url = url else {
                self.image = defaultImage
                return
            }
            let data = try Data(contentsOf: url)
            self.image = UIImage(data: data)!
        } catch {
            self.image = defaultImage
        }
    }
    
    func loadImage(url: String, defaultImage: UIImage = UIImage(named: "NoImage")!) {
        do {
            guard let url = URL(string: url) else {
                self.image = defaultImage
                return
            }
            let data = try Data(contentsOf: url)
            self.image = UIImage(data: data)!
        } catch {
            self.image = defaultImage
        }
    }
}
