//
//  HomeResponse.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/23.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit
import ObjectMapper

class HomeItemModel: Mappable {
    
    var BlockWithHeightProportionSum:String?
    var Id:Int?
    var VersionAreaId:Int?
    var VersionAreaRow:Int?
    var Width:String?
    var Height:String?
    var BlockWithHeightProportion:String?
    var BlockBackgroupImgUrl:String?
    var BlockActionType:Int?
    var BlockUrl:String?
    var Sort:Int?
    var State:Int?
    var IsAddToken:Int?
    
    init() {
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        BlockWithHeightProportionSum <- map["BlockWithHeightProportionSum"]
        Id <- map["Id"]
        VersionAreaId <- map["VersionAreaId"]
        VersionAreaRow <- map["VersionAreaRow"]
        Width <- map["Width"]
        Height <- map["Height"]
        BlockWithHeightProportion <- map["BlockWithHeightProportion"]
        BlockBackgroupImgUrl <- map["BlockBackgroupImgUrl"]
        BlockActionType <- map["BlockActionType"]
        BlockUrl <- map["BlockUrl"]
        Sort <- map["Sort"]
        State <- map["State"]
        IsAddToken <- map["IsAddToken"]
    }
}

class HomeSectionItemModel: Mappable {
    
    var rows:Array<Array<HomeItemModel>>?
    var Id:Int?
    var Title:String?
    var TitleSize:String?
    var TitleColor:String?
    var TitleUrl:String?
    var TitleIconUrl:String?
    var TitleBackgroupImgUrl:String?
    var TitleActionType:Int?
    var Subtitle:String?
    var SubtitleSize:String?
    var SubtitleColor:String?
    var SubtitleUrl:String?
    var SubtitleActionType:Int?
    var IsShowTitle:Int?
    var RowCount:Int?
    var State:Int?
    var Sort:Int?
    var BaseWidth:String?
    var BackgroupColor:String?
    var IsMarqueeSubtitle:Int?
    var IsShowSubtitle:Int?
    var IsAddToken:Int?
    
    init() {
        
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        rows <- map["Rows"]
        Id <- map["Id"]
        Title <- map["Title"]
        TitleSize <- map["TitleSize"]
        TitleColor <- map["TitleColor"]
        TitleUrl <- map["TitleUrl"]
        TitleIconUrl <- map["TitleIconUrl"]
        TitleBackgroupImgUrl <- map["TitleBackgroupImgUrl"]
        TitleActionType <- map["TitleActionType"]
        Subtitle <- map["Subtitle"]
        SubtitleSize <- map["SubtitleSize"]
        SubtitleColor <- map["SubtitleColor"]
        SubtitleUrl <- map["SubtitleUrl"]
        SubtitleActionType <- map["SubtitleActionType"]
        IsShowTitle <- map["IsShowTitle"]
        RowCount <- map["RowCount"]
        State <- map["State"]
        Sort <- map["Sort"]
        BaseWidth <- map["BaseWidth"]
        BackgroupColor <- map["BackgroupColor"]
        IsMarqueeSubtitle <- map["IsMarqueeSubtitle"]
        IsShowSubtitle <- map["IsShowSubtitle"]
        IsAddToken <- map["IsAddToken"]
    }
}

class HomeResponse: Mappable {
    
    var state:Int?
    var msg:String?
    var data:Array<HomeSectionItemModel>?
    var version:Int?
    
    init() {
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        state <- map["State"]
        msg <- map["Msg"]
        data <- map["Data"]
        version <- map["V"]
    }
}

