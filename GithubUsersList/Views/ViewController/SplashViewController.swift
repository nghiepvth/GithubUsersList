//
//  SplashViewController.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/02.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController : BaseViewController {
    
    //Properties: Public

    //Properties: Private
    
    //Method: Life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.replaceNextViewController()
    }
    
    //Method: Public
    
    //Method: Private
    private func replaceNextViewController() {
        let window = Util.KeyWindow()
        let nextViewController: GithubUserListViewController? = R.storyboard.githubUserListStoryboard().instantiateInitialViewController()
        window?.rootViewController = nextViewController
    }
}
