//
//  ZYCoreUtils.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/23.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class ZYCoreUtils: NSObject {
    
    /**
     *  颜色
     */
    
    static func BabyColor(_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)->(UIColor){
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a);
    }
    
    static func StringToCGFloat(str:String)->(CGFloat){
        
        let string = str
        var cgFloat: CGFloat = 0
        
        if let doubleValue = Double(string)
        {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
    
    static func setupBackBarButton(_ viewController:BaseViewController) -> UIBarButtonItem {
        
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        button.setBackgroundImage(UIImage.init(named: "ticon_back"), for: UIControlState.normal)
        button.setTitleColor(ZYConstants.navigationBackBarBttonColor, for: UIControlState.normal)
        button.setTitleColor(ZYConstants.navigationBackBarBttonColor, for: UIControlState.highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(viewController, action: #selector(BaseViewController.clickBackBarButton), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem.init(customView: button)
        return barButton
    }
    
    
    

}
