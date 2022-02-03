//
//  UserDetailViewController.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/03.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay
import UIKit
import RxDataSources
import WebKit

class UserDetailViewController: BaseViewController {
    
    //Properties: Public
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var repositoryListTable: UITableView!
    
    var userName: String = ""
    var viewModel: UserDetailViewModel = .init()
    //Properties: Private
    private var userNameSubject = PublishRelay<String>()
    
    //Method: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindInput()
        bindOutput()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.userNameSubject.accept(userName)
    }
    
    //Method: Public
    
    //Method: Private
}

extension UserDetailViewController {
    func setupView() {
        
    }
    
    func bindInput() {
        self.userNameSubject.bind(to: self.viewModel.input.userName).disposed(by: disposeBag)
        
        self.repositoryListTable.rx.modelSelected(RepositoryModel.self).subscribe (onNext: { repository in
            let webVC = R.storyboard.webViewController().instantiateInitialViewController() as? WebViewController
            webVC?.url = repository.html_url ?? ""
            if let webVC = webVC {
                self.present(webVC, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
    }
    
    func bindOutput() {
        self.viewModel.output.userDetail.subscribe(onNext: { userDetail in
            self.iconImage.loadImage(url: userDetail.avatar_url ?? "")
            self.nameLabel.text = "ユーザー名: \(userDetail.login ?? "")"
            self.fullNameLabel.text = "フルネーム: \(userDetail.name ?? "")"
            self.followerLabel.text = "フォロワー数: \(userDetail.followers ?? 0)"
            self.followingLabel.text = "フォロイー数: \(userDetail.following ?? 0)"
        }).disposed(by: disposeBag)
        
        let repositoryListDataSource = RxTableViewSectionedReloadDataSource<RepositorySectionModelType>(configureCell: { dataSource, tableView, indexPath, item in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.repositoryListCell.identifier, for: indexPath) as! RepositoryListCell
            cell.setData(model: item)
            return cell
        })
        
        self.viewModel.output.repositoryList.subscribe(onNext: { repositoryList in
            let sections = [RepositorySectionModelType(header: "1", items: repositoryList)]
            Observable.just(sections).bind(to: self.repositoryListTable.rx.items(dataSource: repositoryListDataSource)).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}

struct RepositorySectionModelType : SectionModelType {
    var header: String
    var items: [Item]
}

extension RepositorySectionModelType {
    typealias Item = RepositoryModel
    
    init(original: RepositorySectionModelType, items: [Item]) {
        self = original
        self.items = items
    }
}
