//
//  MoyaProvider+Extension.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/23.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import RxSwift
import Moya
import ObjectMapper

public extension Reactive where Base: MoyaProviderType {
    
    /// Designated request-making method.
    ///
    /// - Parameters:
    ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
    ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
    /// - Returns: Single response object.
    public func request<T: Mappable>(_ token: Base.Target, mapper: Mapper<T>, callbackQueue: DispatchQueue? = nil) -> Single<Result<T>> {
        return Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    do {
                        let josnString = try response.mapString()
                        if let object = mapper.map(JSONString: josnString) {
                            single(.success(Result.value(object)))
                        } else {
                            single(.error(MoyaError.stringMapping(response)))
                        }
                    } catch let error {
                        single(.error(error))
                    }
                case let .failure(error):
                    single(.error(error))
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    
    public func requestArray<T: Mappable>(_ token: Base.Target, mapper: Mapper<T>, callbackQueue: DispatchQueue? = nil) -> Single<Result<[T]>> {
        return Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    do {
                        let josnString = try response.mapString()
                        if let array = mapper.mapArray(JSONString: josnString) {
                            single(.success(Result.value(array)))
                        } else {
                            single(.error(MoyaError.stringMapping(response)))
                        }
                    } catch let error {
                        single(.error(error))
                    }
                case let .failure(error):
                    single(.error(error))
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
}
