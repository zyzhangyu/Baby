//
//  AppDelegate.swift
//  DoNotRush
//
//  Created by developer on 2020/9/10.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit
import CoreLocation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,BMKLocationAuthDelegate {
    
    
    func onCheckPermissionState(_ iError: BMKLocationAuthErrorCode) {
        print("查看授权结果")
        print(iError.rawValue)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
     
        
        let bmla: BMKLocationAuth = BMKLocationAuth.sharedInstance()
        bmla.checkPermision(withKey: "msolXEuD2GFlOudniwqGCf3mrTbzCAdH", authDelegate: self)


 
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

