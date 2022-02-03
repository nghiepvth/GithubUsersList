//
//  GithubUserListViewController.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/02.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay
import UIKit
import RxDataSources

class GithubUserListViewController: BaseViewController {
    
    //Properties: Public
    @IBOutlet weak var userListTableView: UITableView!
    
    var viewModel: GithubUserListViewModel = .init()

    //Properties: Private
    
    //Method: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindInput()
        bindOutput()
    }
    
    //Method: Public
    
    //Method: Private
}

extension GithubUserListViewController {
    func setupView() {
    }
    
    func bindInput() {
        self.userListTableView.rx.modelSelected(UserModel.self).subscribe (onNext: { user in
            if let userName = user.login {
                let nextVC: UserDetailViewController? = R.storyboard.userDetailStoryBoard().instantiateInitialViewController() as? UserDetailViewController
                nextVC?.userName = userName
                if let nextVC = nextVC {
                    self.present(nextVC, animated: true, completion: nil)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func bindOutput() {
        
        let userListDataSource = RxTableViewSectionedReloadDataSource<UserlistSectionModelType>(configureCell: { dataSource, tableView, indexPath, item in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userListCell.identifier, for: indexPath) as! UserListCell
            cell.setData(model: item)
            return cell
        })
        
        self.viewModel.output.userList.subscribe(onNext: { userList in
            let sections = [UserlistSectionModelType(header: "1", items: userList)]
            Observable.just(sections).bind(to: self.userListTableView.rx.items(dataSource: userListDataSource)).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}

struct UserlistSectionModelType : SectionModelType {
    var header: String
    var items: [Item]
}

extension UserlistSectionModelType {
    typealias Item = UserModel
    
    init(original: UserlistSectionModelType, items: [Item]) {
        self = original
        self.items = items
    }
}
