//
//  UserInfo.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/20.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import ObjectMapper

class SignInResponse: BaseResponse {
    var user: UserInfo?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        user <- map["result"]
    }
    
}

struct UserInfo: Mappable {
    var id: String = ""
    var name: String = ""
    var age: Int = 0
    var sex: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id   <- map["user_id"]
        name <- map["user_name"]
        age  <- map["user_age"]
        sex  <- map["user_sex"]
    }
}
