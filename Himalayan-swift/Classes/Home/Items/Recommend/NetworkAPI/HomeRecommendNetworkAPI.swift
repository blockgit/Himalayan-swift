//
//  HomeRecommendNetworkAPI.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/6.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit
import AdSupport

/// 首页推荐接口
enum HomeRecommendAPI {
    case HomeRecommendFeedLoad //推荐加载内容
}

extension HomeRecommendAPI {
    var path: String {
        switch self {
        case .HomeRecommendFeedLoad:
            return "http://mobile.ximalaya.com/discovery-feed/v3/mix/ts-1573290472156?appid=0&scale=2&uid=0&version=6.6.21&channel=ios-b1&giftTag=0&deviceId=BF05F658-F41F-49B7-B530-38A9935C02CE&xt=1573290472156&topBuzzVersion=1&onlyBody=false&offset=0&operator=3&traitKey=&network=WIFI&traitValue=&device=iPhone&code=43_440000_4419&categoryId=-2"
            //"http://mobile.ximalaya.com/discovery-feed/v3/mix/ts-1573290472156?appid=0&scale=2&uid=0&version=\(KHimalayanVersion)&channel=ios-b1&giftTag=0&deviceId=\(KDeivceID ?? "BF05F658-F41F-49B7-B530-38A9935C02CE")&xt=\(KDateInt)&topBuzzVersion=1&onlyBody=false&offset=0&operator=3&traitKey=&network=WIFI&traitValue=&device=iPhone&code=43_440000_4419&categoryId=-2"
        }
    }
}


//推荐 header enum
enum HomeRecommendHeaderEnum{
    case focus //轮番图/焦点图
    case square //糖葫芦/一串显示
    case topBuzz //广播
    case guessYouLike //猜你喜欢
}

extension HomeRecommendHeaderEnum{
    var toString: String {
        switch self {
        case .focus:
            return "focus"
        case .square:
            return "square"
        case .topBuzz:
            return "topBuzz"
        case .guessYouLike:
            return "guessYouLike"
        }
    }
}
