//
//  HttpAPI.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/20.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import Moya

public enum HttpAPI {
    case signin(username: String, password: String)
}

// MARK: - TargetType Protocol Implementation
extension HttpAPI: TargetType {
    /// 接口基础的URL
    public var baseURL: URL { return URL(string: "https://myservice.com/")! }
    
    /// 定义每个接口的请求路径
    public var path: String {
        switch self {
        case .signin:
            return "SignIn"
        }
    }
    
    /// 定义每个接口的 http 请求方式
    public var method: Moya.Method {
        return .post
    }
    
    /// 定义每个接口的 test 数据：与 test 有关
    public var sampleData: Data { return Data() }
    
    /// 定义每个接口的 task， request/download...
    public var task: Moya.Task {
        switch self {
        case let .signin(username, password):
            return .requestParameters(
                parameters: ["loginName" : username, "loginPwd" : password],
                encoding: JSONEncoding.default
            )
        }
    }
    
    /// The type of validation to perform on the request. Default is `.none`.
    public var validationType: ValidationType { return .successAndRedirectCodes }
    
    /// 定义每个接口的请求头
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
