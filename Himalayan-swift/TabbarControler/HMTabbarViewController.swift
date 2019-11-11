//
//  HMTabbarViewController.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/10/30.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit

class HMTabbarViewController: UITabBarController {
    
    /// 自定义tabbar
    lazy var tabbar: HMTabbar = {
        var tabbar = HMTabbar.tabbar()
        tabbar.tabbarDelegate = self
        return tabbar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
}

// MARK:自定义Tabbar
extension HMTabbarViewController{
    /// 初始化视图
    func initView() {
        self.viewControllers = [HMBaseNavigationViewController(rootViewController: HomeViewController()),
                                HMBaseNavigationViewController(rootViewController: MyListenViewController()),
                                HMBaseNavigationViewController(rootViewController: FindViewController()),
                                HMBaseNavigationViewController(rootViewController: MeViewController())]
        self.tabBar.addSubview(tabbar)
        self.tabBar.backgroundColor = UIColor.white
        tabbar.snp.makeConstraints { (make) in
            make.top.equalTo(self.tabBar)
            make.right.left.equalTo(self.tabBar)
            make.height.equalTo(self.tabBar.bounds.height)
        }
    }
}

// MARK:实现HMTabbarDelegate协议
extension HMTabbarViewController: HMTabbarDelegate{
    
    /// 点击tabbar项
    /// - Parameter index: 索引
    func HMTabbarSelectIndex(index: Int) {
        if index < self.viewControllers?.count ?? 0 {
            self.selectedIndex = index
        }
    }
    
    
    /// 点击中间播放按钮
    func HMTabbarCenterClick() {
        
    }
}
