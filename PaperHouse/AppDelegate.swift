//
//  AppDelegate.swift
//  PaperHouse
//
//  Created by kunpeng on 2017/6/8.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

import UIKit

let AMapKey = "2ba78a45598f61481a5f9f6239452cc8" //高德地图key

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        configAMapService()
        return true
    }
    
    //配置高德地图
    func configAMapService() {
        
        AMapServices.shared().apiKey = AMapKey
        AMapServices.shared().enableHTTPS = true
    }
    
}

