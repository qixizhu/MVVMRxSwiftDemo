//
//  Result.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/20.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import ObjectMapper

public enum Result<Value> {
    case value(Value)
    case error(Swift.Error)
    
    public func isSuccess() -> Bool {
        switch self {
        case .value(_):
            return true
        case .error(_):
            return false
        }
    }
    
    public func isFailure() -> Bool {
        switch self {
        case .value(_):
            return false
        case .error(_):
            return true
        }
    }
    
    func map<T>(_ transform: (Value) throws -> T) -> Result<T> {
        switch self {
        case .value(let object):
            do {
                let nextObject = try transform(object)
                return Result<T>.value(nextObject)
            } catch {
                return Result<T>.error(error)
            }
        case .error(let error):
            return Result<T>.error(error)
        }
    }
}

func mapValue<T, K>(_ transform: @escaping (T) throws -> K) -> (Result<T>) -> Result<K> {
    return { result in
        result.map(transform)
    }
}
