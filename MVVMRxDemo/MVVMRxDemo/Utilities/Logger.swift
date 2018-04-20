//
//  Logger.swift
//  MVVMRxDemo
//
//  Created by Master on 2018/4/20.
//  Copyright © 2018年 七夕猪. All rights reserved.
//

import SwiftyBeaver

#if DEBUG
public let log = initDebugLog()
#else
public let log = initReleaseLog()
#endif

private func initDebugLog() -> SwiftyBeaver.Type {
    let console = ConsoleDestination()
    console.minLevel = .verbose
    SwiftyBeaver.addDestination(console)
    return SwiftyBeaver.self
}

private func initReleaseLog() -> SwiftyBeaver.Type {
    return SwiftyBeaver.self
}
