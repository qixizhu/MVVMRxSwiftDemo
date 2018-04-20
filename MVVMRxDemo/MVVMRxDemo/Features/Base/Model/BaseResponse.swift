//
//  BaseResponse.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/20.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import ObjectMapper

public class BaseResponse: Mappable {
    /// 请求结果代码：
    var code: Int = -1
    /// 请求结果信息
    var message: String = ""
    
    public init() {}
    
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
        code    <- map["code"]
        message <- map["message"]
    }
}
