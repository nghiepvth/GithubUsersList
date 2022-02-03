//
//  UserModel.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/02.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation

class UserModel: Codable {
    let login: String?
    let avatar_url: String?
}

class UserDetailModel: Codable {
    let login: String?
    let avatar_url: String?
    let name: String?
    let followers: Int?
    let following: Int?
}
