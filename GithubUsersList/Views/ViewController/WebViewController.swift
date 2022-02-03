//
//  WebViewController.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/03.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import WebKit

class WebViewController: BaseViewController {
    
    //Properties: Public
    @IBOutlet weak var webView: WKWebView!
    
    var url: String = ""

    //Properties: Private
    
    //Method: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadURL()
    }
    
    //Method: Public
    
    //Method: Private
    private func loadURL() {
        guard let loadURL = URL(string: self.url) else {
            let alert = UIAlertController(title: "エラー", message: "このページは存在してません", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "", style: .default, handler: { _ in
                    self.dismiss(animated: true)
                }))
            present(alert, animated: true, completion: nil)
            return
        }
        
        self.webView.load(URLRequest(url: loadURL))
    }
    
    private func binding() {
        
    }
}
