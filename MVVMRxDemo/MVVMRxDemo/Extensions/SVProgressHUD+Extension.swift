//
//  SVProgressHUD+Extension.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/23.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD {
    /// 设置自定义风格
    public class func setCustomStyle() {
        /// 设置默认风格：dark
        SVProgressHUD.setDefaultStyle(.dark)
        /// 设置多少秒之后隐藏
        SVProgressHUD.setMaximumDismissTimeInterval(2)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        /// 设置 mask type
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    /// 展示活动指示器
    ///
    /// - Parameter message: 消息
    public class func showActivityIndicator(with message: String? = nil) {
        SVProgressHUD.show(withStatus: message)
    }
    
    /// 展示消息
    ///
    /// - Parameter message: 消息
    public class func showMessage(with message: String) {
        SVProgressHUD.showInfo(withStatus: message)
    }
    
    /// 展示成功的消息
    ///
    /// - Parameter message: 消息
    public class func showSuccess(with message: String? = nil) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
    /// 展示失败的消息
    ///
    /// - Parameter message: 消息
    public class func showError(with message: String? = nil) {
        SVProgressHUD.showError(withStatus: message)
    }
}
