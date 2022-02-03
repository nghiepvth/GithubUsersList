//
//  APIClient.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/02.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import RxRelay
import Alamofire

final public class APIClient {
    
    static func request<T: Codable>(success: PublishRelay<T>,
                        error: PublishRelay<CustomAppError>,
                        url: URL,
                        params: [String: String]? = nil,
                        method: HTTPMethod = .get,
                        encoding: ParameterEncoding = JSONEncoding.default,
                        headers: HTTPHeaders? = nil) {
        
        
        AF.request(url, method: method, parameters: params, encoding: encoding, headers: headers).responseDecodable(of: T.self) { response in
            print(response)
            switch response.result {
            case .success:
                guard
                    let json = response.data,
                    let model = try? JSONDecoder().decode(T.self, from: json)
                else {
                    error.accept(CustomAppError.unexpectedError())
                    return
                }
                
                success.accept(model)
                break
            case .failure:
                error.accept(CustomAppError.unexpectedError())
                break
            }
        }
    }
}
