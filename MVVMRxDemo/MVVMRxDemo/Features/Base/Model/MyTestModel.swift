//
//  MyTestModel.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/23.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import ObjectMapper

struct TestModel: Mappable {
    var postId = 0
    var id = 0
    var name: String = ""
    var email: String = ""
    var body: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        postId <- map["postId"]
        id     <- map["id"]
        name   <- map["name"]
        email  <- map["email"]
        body   <- map["body"]
    }
}
