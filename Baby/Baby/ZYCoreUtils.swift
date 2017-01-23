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

}
