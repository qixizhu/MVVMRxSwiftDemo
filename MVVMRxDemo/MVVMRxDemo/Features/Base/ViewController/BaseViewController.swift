//
//  BaseViewController.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/20.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

/// View controller 基类
open class BaseViewController: UIViewController {
    // MARK: - 属性
    /// MJRefreshHeader 控件
    open private(set) lazy var mjHeader: MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader(
            refreshingTarget: self,
            refreshingAction: #selector(beginRefresh(_:))
            )!
        header.lastUpdatedTimeLabel.isHidden = true
        header.isAutomaticallyChangeAlpha = true
        return header
    }()
    
    /// MJRefreshFooter 控件
    open private(set) lazy var mjFooter: MJRefreshAutoNormalFooter = {
        let footer = MJRefreshAutoNormalFooter(
            refreshingTarget: self,
            refreshingAction: #selector(beginLoadMore(_:))
            )!
        
        /// 设置没有更多数据显示的文字
        footer.setTitle("没有更多了", for: .noMoreData)
        /// 滑到底部是否自动刷新
        footer.isAutomaticallyRefresh = false
        /// 隐藏刷新时的文字
        footer.isRefreshingTitleHidden = true
        footer.isAutomaticallyChangeAlpha = true
        return footer
    }()
    
    /// RxSwift DisposeBag
    fileprivate lazy var _bag = DisposeBag()
    public var bag: DisposeBag {
        return _bag
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        prepareViewModel()
    }
    
    /// 初始化视图的方法，不需要手动调用
    open func prepareView() {}
    
    /// 声明ViewModel的方法，不需要手动调用
    open func prepareViewModel() {}
    
    /// 下拉刷新触发的方法，不需要手动调用
    @objc open func beginRefresh(_ sender: AnyObject) {}
    
    /// 上拉加载触发的方法，不需要手动调用
    @objc open func beginLoadMore(_ sender: AnyObject) {}
    
    deinit {
        log.verbose("\(type(of: self)) deinited.")
    }
    
}
