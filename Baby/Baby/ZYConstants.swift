//
//  ZYConstants.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/19.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class ZYConstants: NSObject {
    
    /**
     *   当前设备屏幕的宽带
     **/
    static let SCREENWIDTH = UIScreen.main.bounds.width
    
    /**
     *   当前设备屏幕的高度
     **/
    static let SCREENHEIGHT = UIScreen.main.bounds.height
    
    /**
     *   首页ImageViewCell的高度
     **/
    static let cellImageViewWidth =  ((ZYConstants.SCREENWIDTH - CGFloat(15.0 * 2) - 15) / 2)
    
    /**
     *   1像素的线
     **/
    static let singleLine = (1 / UIScreen.main.scale)
    static let singleLineAdjustOffset = (1 / UIScreen.main.scale)/2

    
    /**
     *   HomeViewController中Collectionview注册的Cell
     *
     *  CellHot 热门推荐
     *  CellInsurance 延保专区
     *  CellAppreciation 延保增值服务
     *  CellGasoline 加油专区
     *  CellInsure 保险专区
     *  CellMore 更多功能
     **/
    static let CellHot = "hot"
    static let CellInsurance = "insurance"
    static let CellAppreciation = "appreciation"
    static let CellGasoline = "gasoline"
    static let CellInsure = "insure"
    static let CellMore = "more"

}
