//
//  HMBaseModel.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/3.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit


/// 成功返回的根类
class HMBaseSucessModel {
    
}

/// 错误返回的根类
class HMBaseErrorModel {
    /// 错误信息
    var msg: String = ""
    
    /// 错误码
    var errorCode: Int = -9999
}
