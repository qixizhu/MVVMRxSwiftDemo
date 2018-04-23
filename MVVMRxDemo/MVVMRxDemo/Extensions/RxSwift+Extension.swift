//
//  RxSwift+Extension.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/23.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import RxSwift

extension ObservableType {
    public func hideKeyboard() -> Observable<E> {
        return self.do(onNext: { (_) in
            UIApplication.shared.keyWindow?.endEditing(true)
        }, onError: { (_) in
            UIApplication.shared.keyWindow?.endEditing(true)
        })
    }
}
