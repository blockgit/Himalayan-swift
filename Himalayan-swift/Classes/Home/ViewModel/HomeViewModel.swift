//
//  HomeViewModel.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/4.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit

class HomeViewModel {
    var homeCategoryModel: HomeCategoryModel?
    required init() {
        
    }
    /// 加载数据
    func loadData(loadSucess: @escaping ()->Void) {
        weak var Weakself = self
        HMHttpAPICommon.GET(url: HomeAPI.HomeCategoryList.path) { (json) in
            
            Weakself?.homeCategoryModel = HomeCategoryModel.deserialize(from: json)
            loadSucess()
        }
    }
}
