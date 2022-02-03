//
//  CustomAppError.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/02.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation

public struct CustomAppError: Error {
    var message: String = ""
    var errorCode: String?
    var errorType: ErrorType = .NONE
    
    enum ErrorType: Int {
        case NONE = -1
        case UNEXPECTED = 999
    }
    
    static func unexpectedError() -> CustomAppError{
        return CustomAppError(message: "unexpected", errorCode: "102", errorType: .UNEXPECTED)
    }
}
