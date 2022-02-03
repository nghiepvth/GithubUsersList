//
//  UserListCell.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/02.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import UIKit

class UserListCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setData(model: UserModel) {
        self.nameLabel.text = model.login
        self.iconImage.loadImage(url: model.avatar_url ?? "")
    }
}
