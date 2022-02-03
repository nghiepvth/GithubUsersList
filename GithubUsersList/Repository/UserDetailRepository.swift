//
//  UserDetailRepository.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/03.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire

final class UserDetailRepository {
    
    let path = "/users"
    
    public let success = PublishRelay<UserDetailModel>()
    public let error = PublishRelay<CustomAppError>()
    
    func getUserDetail(userName: String) {
        guard let url = URLComponents(string: CustomAppConst.URL + path + "/\(userName)") else {
            error.accept(CustomAppError.unexpectedError())
            return
        }
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json"]
        
        let urlQuery: URL = url.url!
        
        APIClient.request(success: self.success, error: self.error, url: urlQuery, headers: headers)
    }
}

