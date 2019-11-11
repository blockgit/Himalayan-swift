//
//  Const.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/10/31.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import HandyJSON
import Kingfisher

let KScreenWidth = UIScreen.main.bounds.width
let KScreenHeight = UIScreen.main.bounds.height

let isIphone: Bool = KScreenHeight == 812 ? true : false
let navigationBarHeight: CGFloat = isIphone ? 88 : 64
let tabBarHeight:  CGFloat = isIphone ? 49 + 34 : 49
let statusBarHeight = UIApplication.shared.statusBarFrame.height


/// 设备ID
let KDeivceID: String? = UIDevice.current.identifierForVendor?.uuidString
/// 时间戳
let KDateInt = Int32(Date().timeIntervalSince1970)

/// 喜马拉雅的当前版本
let KHimalayanVersion: String = "6.6.21"


//通知名称


/// 首页所有轮播图通知计时器开始暂停
let FocusTimerNotiyName: String = "FocusTimerNotiyName"


