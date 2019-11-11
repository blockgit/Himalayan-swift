//
//  HomeNetworkAPI.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/3.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit
/// 首页获取内容API枚举
enum HomeAPI{
    case HomeCategoryList //首页列表
}

extension HomeAPI {
    var path: String {
        switch self {
            case .HomeCategoryList:
            return "http://mobile.ximalaya.com/discovery-category/customCategories/1572938374736?channel=ios-b1&code=43_440000_4419&customCategories=%5B%22recommend%22%2C%22vip%22%2C%22single_category-49%22%2C%22lamia%22%2C%22single_category-6%22%2C%22single_category-44%22%2C%22live%22%2C%22paid%22%2C%22single_category-12%22%2C%22single_category-39%22%2C%22single_category-9%22%2C%22single_category-48%22%2C%22single_category-2%22%2C%22single_category-13%22%2C%22single_category-10%22%2C%22single_category-38%22%2C%22single_category-8%22%2C%22single_category-40%22%2C%22single_category-46%22%2C%22html5-9%22%5D&device=iPhone&includeItemTypes=%5B%22vip%22%5D&modifyTime=0&version=\(KHimalayanVersion)"
        }
    }
}


/// 首页显示的分类枚举
enum HomeCategory {
    ///推荐
    case recommend
    ///vip
    case vip
    ///直播
    case lamia
    ///广播
    case live
    ///精品
    case paid
    ///H5显示
    case h5
    ///统一分类
    case single_category
    
    var toString: String {
        switch self {
        case .recommend:
            return "recommend"
        case .vip:
            return "vip"
        case .lamia:
            return "lamia"
        case .live:
            return "live"
        case .paid:
            return "paid"
        case .h5:
            return "h5"
        default:
            return "single_category"
        }
    }
}

