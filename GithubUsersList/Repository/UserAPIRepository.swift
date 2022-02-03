//
//  User.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/02.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire

final class UserAPIRepository {
    
    let path = "/users"
    
    public let success = PublishRelay<[UserModel]>()
    public let error = PublishRelay<CustomAppError>()
    
    func getUserList() {
        guard var url = URLComponents(string: CustomAppConst.URL + path) else {
            error.accept(CustomAppError.unexpectedError())
            return
        }
        
        let queryItems = [URLQueryItem(name: "per_page", value: "60")]
        url.queryItems = queryItems
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json"]
        
        let urlQuery = url.url!
        
        APIClient.request(success: self.success, error: self.error, url: urlQuery, headers: headers)
    }
}
