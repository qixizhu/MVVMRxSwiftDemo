//
//  UserDefaultsHelper.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/23.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import Foundation

public class UserDefaultsHelper {
    private init() { }
    
    public static let shared = UserDefaultsHelper()
    
    private let def = UserDefaults.standard
    
    /// 是否自动登录
    public var isAutoLogin: Bool {
        get {
            return def.bool(forKey: "isAutoSignIn")
        }
        
        set(newValue) {
            def.set(newValue, forKey: "isAutoSignIn")
        }
    }
    
    /// 登录名
    public var loginName: String? {
        get {
            return def.string(forKey: "loginName")
        }
        
        set(newValue) {
            def.set(newValue, forKey: "loginName")
        }
    }
    
    /// 登录密码
    public var password: String? {
        get {
            return def.string(forKey: "password")
        }
        
        set(newValue) {
            def.set(newValue, forKey: "password")
        }
    }
}
