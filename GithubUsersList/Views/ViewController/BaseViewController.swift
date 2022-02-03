//
//  ViewController.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/01/28.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

protocol NonSwipeable {}
protocol BaseViewControllerProtocol {
    func setupView()
    func bindInput()
    func bindOutput()
}

class BaseViewController: UIViewController {
    
    //Properties: Public
    var disposeBag = DisposeBag()
    var isLoading = BehaviorRelay<Bool>(value: false)

    //Properties: Private
    
    //Method: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isLoading.subscribe(onNext: { isLoading in
            if isLoading {
                self.startIndicator()
            } else {
                self.stopIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    //Method: Public
    
    //Method: Private


}

