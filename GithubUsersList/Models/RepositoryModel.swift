//
//  RepositoryModel.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/03.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation

class RepositoryModel: Codable {
    let name: String?
    let language: String?
    let stargazers_count: Int?
    let description: String?
    let html_url: String?
}
