//
//  HomeRecommendModel.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/6.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit
import HandyJSON


/// 推荐加载的内容
class HomeRecommendModel: HandyJSON {
    required init() {}
    
    var msg: String?
    var ret: Int = -1
    var code: String?
    /// 推荐展示展示
    var body: [String : Any]?
    /// 推荐头部展示
    var header: [HomeRecommendHead]?
}


/// 推荐页的头部展示
class HomeRecommendHead: HandyJSON {
    required init() {}
    var item: HomeRecommendHeadItem?
    var itemType: String?
}


/// 推荐页的头部展示Item
class HomeRecommendHeadItem: HandyJSON {
    required init() {}
    
    /// 显示方式，猜你喜欢使用
    var displayStyle: String?
    /// 显示数量
    var loopCount: Int = -1
    /// 广播显示名称
    var greetings: String?
    var list: [[String : Any]?]?
    //决定显示内容
    //focus 轮番图/焦点图
    //square 糖葫芦/一串显示
    //topBuzz 广播
    //guessYouLike //猜你喜欢
    var moduleType: String?
    //标题
    var title: String?
}



/// 轮番图/焦点图类
class HomeRecommendFocus: HandyJSON {
    required init() {}
    var data: [HomeRecommendFocusDetails]?
    var responseId: Int64 = -1
    var ret: Int = -1
    
}


/// 轮番图/焦点图类 详细
class HomeRecommendFocusDetails: HandyJSON {
    required init() {}
    
    /// 轮番图
    var cover: String?
    /// 是否广告
    var isAd: Bool = false
    /// 名称
    var name: String?
    ///  广告连接或者收听播放连接
    var realLink: String?
    /// 背景颜色
    var titleBgColor: UIColor?
}


/// 推荐糖葫芦数据
class HomeRecommendSquare: HandyJSON {
    required init() {}
    
    /// 内容类型
    var contentType: String?
    /// 显示的图片
    var coverPath: String?
    /// 显示的标题
    var title: String?
    
    
}


/// 推荐糖葫芦数据Properties
class HomeRecommendSquareProperties: HandyJSON {
    required init() {}
    
    /// 如果需要点击收听，跳转
    var uri: String?
}

class HomeRecommendFM: HandyJSON {
    required init() {}
    
    /// 频道ID
    var channelId: Int = -1
    //频道名称
    var channelName: String?
    
    /// FM内容
    var track: HomeRecommendFMTrack?
    
}

class HomeRecommendFMTrack: HandyJSON {
    required init() {}
    
    var albumId: Int = -1
    var albumTitle: String?
    /// 显示标题
    var title: String?
    /// 昵称名称
    var nickname: String?
}

class HomeRecommendYouLike: HandyJSON {
    required init() {}
    var albumId: Int = -1
    var albumIntro: String?
    var category: String?
    /// 是否精品
    var isPaid: Bool = false
    /// 0未完结,1连载？,2完结
    var isFinished: Int = 0
    ///  VIP免费,也就是收费的必须VIP收听
    var isVipFree: Bool = false
    /// 播放数量
    var playsCount: Int64 = 0
    /// 二级标题
    var subtitle: String?
    /// 显示的标题
    var title: String?
}

