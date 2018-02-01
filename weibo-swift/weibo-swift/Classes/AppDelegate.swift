//
//  AppDelegate.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/19.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

let mainColor = UIColor(red: 253/255, green: 109/255, blue: 9/255, alpha: 1)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var defaultVc: UIViewController? {
        let isLogin = UserAccountTool.shareInstance.isLogin
        
        return isLogin ? WelcomeViewController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().tintColor = mainColor
        
        UITabBar.appearance().tintColor = mainColor
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = defaultVc
        window?.makeKeyAndVisible()
        
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
