//
//  HttpService.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/23.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya
import ObjectMapper

class HttpService {
    private init() {}
    
    let provider = MoyaProvider<HttpAPI>()
    
    static let shared = HttpService()
    
    func signIn(username: String, password: String) -> Observable<Result<SignInResponse>> {
        return provider.rx
            .request(
                .signin(username: username, password: password),
                mapper: Mapper<SignInResponse>()
            )
            .catchError({ (error) -> Single<Result<SignInResponse>> in
                return Single.just(Result.error(error))
            })
            .asObservable()
    }
}
