//
//  AppDelegate.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/10/29.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?//如果不是多窗口模式，需要自己在AppDelegate中添加window属性
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.rootViewController = HMTabbarViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

