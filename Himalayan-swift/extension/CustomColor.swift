//
//  CustomColor.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/10/30.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Tabbar 普通颜色
    class var tabbarNomalColor: UIColor {
        return UIColor.gray
    }
    /// Tabbar 选中的颜色
    class var tabbarSelectColor: UIColor {
        return RGB(R: 230, G: 109, B: 77)
    }
    class func RGB(R: CGFloat,G: CGFloat,B: CGFloat) -> UIColor {
        return UIColor.init(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: 1.0)
    }
}
