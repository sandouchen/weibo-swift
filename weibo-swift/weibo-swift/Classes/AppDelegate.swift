//
//  AppDelegate.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/19.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        /* 手动创建 Window
        UITabBar.appearance().tintColor = UIColor(red: 253/255, green: 109/255, blue: 9/255, alpha: 1)

        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        */
        
        UINavigationBar.appearance().tintColor = UIColor(red: 253/255, green: 109/255, blue: 9/255, alpha: 1)
        
        return true
    }

}

/*
 自定义Log：
 Log在Debug下打印,在release下不打印
 定义标记项 —> buildSettings —> 搜索swift flag —> Debug -> -D DEBUG
 */
func SDLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName) : [\(lineNum)] - \(messsage)")
        
    #endif
}
