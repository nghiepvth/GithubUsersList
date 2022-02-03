//
//  GithubUserListViewModel.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/02.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import Unio
import RxSwift
import RxRelay

protocol GithubUserListViewModelType : AnyObject {
    var input: InputWrapper<GithubUserListViewModel.Input> { get }
    var output: OutputWrapper<GithubUserListViewModel.Output> { get }
}

class GithubUserListViewModel: UnioStream<GithubUserListViewModel>, GithubUserListViewModelType {
    
    init(extra: Extra = .init(
        userApi: UserAPIRepository()
    )) {
        super.init(input: Input(), state: State(), extra: extra, logic: GithubUserListViewModel.self)
    }
    
    required init<Logic>(input: Logic.Input, state: Logic.State, extra: Logic.Extra, logic _: Logic.Type) where Input == Logic.Input, Output == Logic.Output, Logic : LogicType {
        fatalError("could not be called anymore")
    }
}

extension GithubUserListViewModel {
    struct Input: InputType {
    }
    
    struct Output: OutputType {
        let userList: PublishRelay<[UserModel]>
        let errors: PublishRelay<CustomAppError>
    }
    
    struct Extra: ExtraType {
        let userApi: UserAPIRepository
    }
    
    struct State: StateType {
        let userList = PublishRelay<[UserModel]>()
        let errors = PublishRelay<CustomAppError>()
    }
}

extension GithubUserListViewModel {
    
    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let state = dependency.state
        let extra = dependency.extra
        
        extra.userApi.getUserList()
        
        extra.userApi.success.subscribe(onNext: { result in
            state.userList.accept(result)
        }).disposed(by: disposeBag)
        
        extra.userApi.error.bind(to: state.errors).disposed(by: disposeBag)
        
        return GithubUserListViewModel.Output(
            userList: state.userList,
            errors: state.errors
        )
    }
}
