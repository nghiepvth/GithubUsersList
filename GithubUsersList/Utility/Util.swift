//
//  Util.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/02.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import UIKit

struct Util {
    static func KeyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
    }
    
    static func RootViewController() -> UIViewController? {
        guard let window = Util.KeyWindow() else { return nil }
        
        if let presented = window.rootViewController?.presentedViewController {
            return presented
        } else {
            return window.rootViewController
        }
    }
}
