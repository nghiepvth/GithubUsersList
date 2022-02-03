//
//  UserDetailViewModel.swift
//  GithubUsersList
//
//  Created by Stagit Stephan on 2022/02/03.
//  Copyright © 2022 Stagit Stephan. All rights reserved.
//

import Foundation
import Unio
import RxSwift
import RxRelay

protocol UserDetailViewModelType : AnyObject {
    var input: InputWrapper<UserDetailViewModel.Input> { get }
    var output: OutputWrapper<UserDetailViewModel.Output> { get }
}

class UserDetailViewModel: UnioStream<UserDetailViewModel>, UserDetailViewModelType {
    
    init(extra: Extra = .init(
        userDetailApi: UserDetailRepository(),
        repositoryApi: RepositoryAPIRepository()
    )) {
        super.init(input: Input(), state: State(), extra: extra, logic: UserDetailViewModel.self)
    }
    
    required init<Logic>(input: Logic.Input, state: Logic.State, extra: Logic.Extra, logic _: Logic.Type) where Input == Logic.Input, Output == Logic.Output, Logic : LogicType {
        fatalError("could not be called anymore")
    }
}

extension UserDetailViewModel {
    struct Input: InputType {
        let userName = PublishRelay<String>()
    }
    
    struct Output: OutputType {
        let userDetail: PublishRelay<UserDetailModel>
        let repositoryList: PublishRelay<[RepositoryModel]>
        let errors: PublishRelay<CustomAppError>
    }
    
    struct Extra: ExtraType {
        let userDetailApi: UserDetailRepository
        let repositoryApi: RepositoryAPIRepository
    }
    
    struct State: StateType {
        let userDetail = PublishRelay<UserDetailModel>()
        let repositoryList = PublishRelay<[RepositoryModel]>()
        let errors = PublishRelay<CustomAppError>()
    }
}

extension UserDetailViewModel {
    
    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let state = dependency.state
        let extra = dependency.extra
        let input = dependency.inputObservables
        
        input.userName.subscribe(onNext: { userName in
            extra.userDetailApi.getUserDetail(userName: userName)
            extra.repositoryApi.getUserRepositoryList(userName: userName)
        }).disposed(by: disposeBag)
        
        extra.userDetailApi.success.subscribe(onNext: { result in
            state.userDetail.accept(result)
        }).disposed(by: disposeBag)
        
        extra.userDetailApi.error.bind(to: state.errors).disposed(by: disposeBag)
        
        extra.repositoryApi.success.subscribe(onNext: { result in
            state.repositoryList.accept(result)
        }).disposed(by: disposeBag)
        
        return UserDetailViewModel.Output(
            userDetail: state.userDetail,
            repositoryList: state.repositoryList,
            errors: state.errors
        )
    }
}

