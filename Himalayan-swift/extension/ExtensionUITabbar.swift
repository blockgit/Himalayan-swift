//
//  ExtensionUITabbar.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/10/30.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit


extension UITabBar{
    
    /// 处理UITabbarButton 背景颜色的问题
    open override func layoutSubviews() {
        superview?.layoutSubviews()
        for barButton in self.subviews {
            if barButton.isKind(of: NSClassFromString("UITabBarButton")!) {
                barButton.backgroundColor = UIColor.white
            }
        }
    }
}
