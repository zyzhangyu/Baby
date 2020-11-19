//
//  UseLocationViewModel.swift
//  DoNotRush
//
//  Created by developer on 2020/10/19.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation


struct UseLocationViewModel {
    
    var address:String
}


extension UseLocationViewModel {
    
}


class UseLocationWithViewModel:NSObject, ObservableObject, BMKLocationManagerDelegate {
    
    let locationManager = BMKLocationManager.init()

    override init() {
        
        
        print("view did load 为啥不打印呀")
        print("要开始第一次定位了")
        super.init()

        //        locationManager.delegate = self
                //设置返回位置的坐标系类型
                locationManager.coordinateType = BMKLocationCoordinateType.BMK09LL
                //设置距离过滤参数
                locationManager.distanceFilter = kCLDistanceFilterNone
                ////设置预期精度参数
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                //设置应用位置类型
                locationManager.activityType = CLActivityType.automotiveNavigation
                /////设置是否自动停止位置更新
                locationManager.pausesLocationUpdatesAutomatically = true;
                //设置位置获取超时时间
                locationManager.locationTimeout = 10;
                //设置获取地址信息超时时间
                locationManager.reGeocodeTimeout = 10;
                
                locationManager.delegate = self
                
        //            *  @brief 单次定位。如果当前正在连续定位，调用此方法将会失败，返回NO。\n该方法将会根据设定的 desiredAccuracy 去获取定位信息。如果获取的定位信息精确度低于 desiredAccuracy ，将会持续的等待定位信息，直到超时后通过completionBlock返回精度最高的定位信息。\n可以通过 stopUpdatingLocation 方法去取消正在进行的单次定位请求。
        //            *  @param withReGeocode 是否带有逆地理信息(获取逆地理信息需要联网)
        //            *  @param withNetWorkState 是否带有移动热点识别状态(需要联网)
        //            *  @param completionBlock 单次定位完成后的Block
        //            *  @return 是否成功添加单次定位Request
                locationManager.requestLocation(withReGeocode: true, withNetworkState: true) { (bmlocation, bmlocationNetworkState, bmerror) in
                    
                    print("查看单次定位返回的结果")
                    
                    print(bmlocation)
        //            let address = bmlocation?.rgcData?.province + bmlocation?.rgcData?.city + bmlocation?.rgcData?.district + bmlocation?.rgcData?.town + bmlocation?.rgcData?.locationDescribe
        //            print(address)
                    print(bmlocation?.rgcData?.description)
                    print(bmlocationNetworkState)
                    print(bmerror)
                }

    }
    
    func stratLocation()   {

    }
    
}

extension UseLocationViewModel {
    
     //
    //    /**
    //     *  @brief 为了适配app store关于新的后台定位的审核机制（app store要求如果开发者只配置了使用期间定位，则代码中不能出现申请后台定位的逻辑），当开发者在plist配置NSLocationAlwaysUsageDescription或者NSLocationAlwaysAndWhenInUseUsageDescription时，需要在该delegate中调用后台定位api：[locationManager requestAlwaysAuthorization]。开发者如果只配置了NSLocationWhenInUseUsageDescription，且只有使用期间的定位需求，则无需在delegate中实现逻辑。
    //     *  @param manager 定位 BMKLocationManager 类。
    //     *  @param locationManager 系统 CLLocationManager 类 。
    //     *  @since 1.6.0
    //     */
    //    - (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager doRequestAlwaysAuthorization:(CLLocationManager * _Nonnull)locationManager;
    //
    //    /**
    //     *  @brief 当定位发生错误时，会调用代理的此方法。
    //     *  @param manager 定位 BMKLocationManager 类。
    //     *  @param error 返回的错误，参考 CLError 。
    //     */
    //    - (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error;
        
        
        func bmkLocationManager(_ manager: BMKLocationManager, doRequestAlwaysAuthorization locationManager: CLLocationManager) {
            
            print("请求逻辑的回调 因为只在使用中调用一次 所以不用事先")
        }
        
        func bmkLocationManager(_ manager: BMKLocationManager, didFailWithError error: Error?) {
            print("百度地图定位失败")
        }

 
}

