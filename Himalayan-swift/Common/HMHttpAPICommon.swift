//
//  HMHttpAPICommon.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/2.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit
import Alamofire

typealias ResultClosure = (_ result: String?)->Void

class HMHttpAPICommon {
    class func GET(url: String,paramters: [String : Any]? = nil,result: @escaping ResultClosure) {
        AF.request(url,parameters:paramters).responseString {
            (response) in
            switch response.result {
            case .success(_):
                result(response.value)
                break
            default:
                result(response.value)
                break
            }
        }
    }
    /// 获取图片触摸点颜色
    ///
    /// 参考资料
    /// https://blog.csdn.net/huangfei711/article/details/76189655
    /// - Parameters:
    ///   - image: 要获取颜色的图片
    ///   - point: 触摸点
    /// - Returns: 获取到的颜色
    class func cxg_getPointColor(withImage image: UIImage, point: CGPoint) -> UIColor? {
        
        guard CGRect(origin: CGPoint(x: 0, y: 0), size: image.size).contains(point) else {
            return nil
        }

        let pointX = trunc(point.x);
        let pointY = trunc(point.y);

        let width = image.size.width;
        let height = image.size.height;
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        var pixelData: [UInt8] = [0, 0, 0, 0]

        pixelData.withUnsafeMutableBytes { pointer in
            if let context = CGContext(data: pointer.baseAddress, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue), let cgImage = image.cgImage {
                context.setBlendMode(.copy)
                context.translateBy(x: -pointX, y: pointY - height)
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        }

        let red = CGFloat(pixelData[0]) / CGFloat(255.0)
        let green = CGFloat(pixelData[1]) / CGFloat(255.0)
        let blue = CGFloat(pixelData[2]) / CGFloat(255.0)
        let alpha = CGFloat(pixelData[3]) / CGFloat(255.0)

        if #available(iOS 10.0, *) {
            return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}
