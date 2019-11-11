//
//  HomeCategorySearchView.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/1.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit
import JXCategoryView

class HomeCategorySearchView: UIView {
    
    @IBOutlet weak var topCategoryView: UIView!
    @IBOutlet weak var searchView: UIView!
    
    var isScrollNotiy: Bool = false
    
    lazy var lineView: JXCategoryIndicatorLineView = {
        var lineView: JXCategoryIndicatorLineView = JXCategoryIndicatorLineView()
        lineView.indicatorWidth = 25.0
        lineView.indicatorHeight = 3.0
        lineView.indicatorColor = UIColor.orange
        lineView.lineStyle = .lengthen
        return lineView
    }()
    
    /// 头部分栏，三方
    lazy var categoryView: JXCategoryTitleImageView = {
        var categoryView: JXCategoryTitleImageView = JXCategoryTitleImageView()
        categoryView.delegate = self
        categoryView.backgroundColor = UIColor.clear
        categoryView.titleFont = UIFont.systemFont(ofSize: 14)
        categoryView.titleSelectedFont = UIFont.boldSystemFont(ofSize: 16)
        categoryView.titleColor = UIColor.black
        categoryView.titleSelectedColor = UIColor.black
        categoryView.imageSize = CGSize(width: 46.0, height: 28.0)
        categoryView.imageZoomScale = 1.3
        categoryView.isImageZoomEnabled = true
        categoryView.titleLabelZoomScale = 1.3
        categoryView.isTitleLabelZoomEnabled = true
        categoryView.isContentScrollViewClickTransitionAnimationEnabled = false
        categoryView.indicators = [lineView]
        return categoryView
    }()
    
    /// 快速初始化
    class func load() -> HomeCategorySearchView{
        let retView: HomeCategorySearchView = Bundle.main.loadNibNamed("HomeCategorySearchView", owner: nil, options: nil)?.last as! HomeCategorySearchView
        return retView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.topCategoryView.addSubview(categoryView)
        categoryView.snp.makeConstraints { (make) in
            make.edges.equalTo(topCategoryView)
        }
    }

}

//MARK:主题设置
extension HomeCategorySearchView{
    
}

extension HomeCategorySearchView: JXCategoryViewDelegate{
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        
    }
    func categoryView(_ categoryView: JXCategoryBaseView!, didClickSelectedItemAt index: Int) {
        
    }
    func categoryView(_ categoryView: JXCategoryBaseView!, didScrollSelectedItemAt index: Int) {
        isScrollNotiy = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: FocusTimerNotiyName), object: true)
    }
    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        if isScrollNotiy == false {
            isScrollNotiy = true
            //发送通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: FocusTimerNotiyName), object: false)
        }
    }
}
