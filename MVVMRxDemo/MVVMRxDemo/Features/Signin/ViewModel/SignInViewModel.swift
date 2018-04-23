//
//  SignInViewModel.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/23.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa
import ObjectMapper
import CryptoSwift

class SignInViewModel {
    
    /// 是否可以点击登录按钮
    let signinEnabled: Driver<Bool>
    
    /// 正在登录
    let signingIn: Observable<Bool>
    
    /// 是否自动登录，也可以用 BehaviorSubject ，都可以发送默认元素
    /// UserDefaultsHelper是自定义的存储用户设置的单例类
    let isAutoSignin = BehaviorRelay<Bool>(value: UserDefaultsHelper.shared.isAutoLogin)
    
    /// 登录结果
    let signedIn: Observable<Result<BaseResponse>>
    
    init(
        input: (
            username: Driver<String>,
            password: Driver<String>,
            loginTaps: Observable<Void>,
            goReturnKyeTaps: PublishSubject<Void>
        ),
        provider: MoyaProvider<HttpAPI> = MoyaProvider<HttpAPI>()
    ) {
        let signingIn = ActivityIndicator()
        self.signingIn = signingIn.asObservable()
        
        // 用户名字符长度大于一返回 true
        let usernameAvaliable = input.username.map { $0.count > 1 }
        // 密码字符长度大于一返回 true
        let passwordAvaliable = input.password.map { $0.count > 1 }
        // 当用户名、密码输入符合要求，且网络不是正在请求状态，返回 true
        signinEnabled = Driver.combineLatest(
            usernameAvaliable,
            passwordAvaliable,
            signingIn
        ) { $0 && $1 && !$2 }.distinctUntilChanged()
        
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
            (username: $0, password: $1)
        }
        
        signedIn = Observable.merge(input.loginTaps, input.goReturnKyeTaps).withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in
                return provider.rx
                    .request(
                        .signin(username: pair.username, password: pair.password.md5()),
                        mapper: Mapper<BaseResponse>()
                    )
                    // 因为要监控 error，且如果不处理 error 事件，那么 request 的请求链在发生
                    // error 事件后，将不会再次执行，即点击 登录 按钮，不会再次请求网络
                    // 这是 RxSwift 事件流的特性，所以这里必须要处理发生错误返回
                    .catchError({ (error) -> PrimitiveSequence<SingleTrait, Result<BaseResponse>> in
                        return Single.just(Result.failure(error))
                    })
                    // 用户监控网络请求，ActivityIndicator.swift
                    .trackActivity(signingIn)
            }
            .share(replay: 1)
        
    }
    
}
