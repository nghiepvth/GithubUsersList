//
//  RepositoryListCell.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/03.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import UIKit

class RepositoryListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setData(model: RepositoryModel) {
        self.nameLabel.text = "リポジトリ名: \(model.name ?? "")"
        self.languageLabel.text = "開発言語: \(model.language ?? "")"
        self.starLabel.text = "スター数: \(model.stargazers_count ?? 0)"
        self.descriptionLabel.text = "スター数: \(model.description ?? "")"
    }
}
