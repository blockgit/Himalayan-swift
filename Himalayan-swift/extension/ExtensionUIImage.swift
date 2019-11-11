//
//  ExtensionUIImage.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/10.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     根据坐标获取图片中的像素颜色值
     */
    subscript (x: Int, y: Int,alpha: CGFloat) -> UIColor? {
         
        if x < 0 || x > Int(size.width) || y < 0 || y > Int(size.height) {
            return nil
        }
         
        let provider = self.cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData)
         
        let numberOfComponents = 4
        let pixelData = ((Int(size.width) * y) + x) * numberOfComponents
         
        let r = CGFloat(data![pixelData]) / 255.0
        let g = CGFloat(data![pixelData + 1]) / 255.0
        let b = CGFloat(data![pixelData + 2]) / 255.0
//        let a = CGFloat(data![pixelData + 3]) / 255.0
         
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}
