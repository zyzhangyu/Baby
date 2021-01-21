
import Foundation

public struct IDCard {
    
    ///身份证号姓名
    public var cardName: String?
    
    ///身份证名族
    public var cardNation:String?
    
    ///身份证住址
    public var cardAddress:String?
    
    ///身份证号码
    public var cardNumber:String?
}


public struct IDCardInfo {
    
    ///身份证号姓名
    public var cardName: [String]
    
    ///身份证名族
    public var cardNation:[String]
    
    ///身份证住址
    public var cardAddress:[String]
    
    ///身份证号码
    public var cardNumber:[String]
}
