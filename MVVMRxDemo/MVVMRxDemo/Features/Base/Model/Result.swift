//
//  Result.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/20.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import ObjectMapper

public enum Result<T> {
    case success(T)
    case failure(Swift.Error)
    
    public func isSuccess() -> Bool {
        switch self {
        case .success(_):
            return true
        case .failure(_):
            return false
        }
    }
    
    public func isFailure() -> Bool {
        switch self {
        case .success(_):
            return false
        case .failure(_):
            return true
        }
    }
}
