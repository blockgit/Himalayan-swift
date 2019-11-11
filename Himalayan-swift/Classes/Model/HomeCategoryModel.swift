//
//  HomeCategoryModel.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/4.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit
import HandyJSON


/// 首页获取分类列表model
class HomeCategoryModel: HandyJSON {
    required init() {}
    var ret: Int = -1
    var msg: String?
    var customCategoryList: [HomeCategoryDetailsModel]?
}


/// 分类列表详细内容
class HomeCategoryDetailsModel: HandyJSON {
    required init() {}
    var id: String?
    var title: String?
    /// 显示内容的方式，h5 的直接加载url地址
    var itemType: String?
    var categoryId: Int = -1
    var categoryType: Int = -1
    var moduleType: Int = -1
    ///  显示的图片
    var coverPath: String?
    /// 未选中时的显示图片
    var unactiveCoverPath: String?
    /// 选中时的显示图片
    var activeCoverPath: String?
    var recommendType: String?
    
    /// itemType 为h5时 直接加载url内容
    var url:String?
    
    /// 是否默认选中
    var defaultSelected: Bool = false
    
}
