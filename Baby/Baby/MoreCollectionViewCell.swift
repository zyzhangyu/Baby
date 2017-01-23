//
//  MoreCollectionViewCell.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/23.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class MoreCollectionViewCell: UICollectionViewCell {
    
    fileprivate let iconImage = UIImageView.init()
    fileprivate let iconName = UILabel.init()
    fileprivate let alertLabel = UILabel.init()
    
    var icon : UIImage? {
        didSet {
            iconImage.image = icon
        }
    }
    
    var content : String?{
        didSet {
            iconName.text = content
        }
    }
    
    var message: String? {
        didSet {
            alertLabel.text = message
        }
    }
    
    var messageHidden = true {
        didSet{
            alertLabel.isHidden = messageHidden
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        iconImage.contentMode = UIViewContentMode.scaleAspectFill
        iconImage.backgroundColor = UIColor.clear
        contentView.addSubview(iconImage)
        iconName.backgroundColor = UIColor.clear
        iconName.textColor = ZYCoreUtils.BabyColor(51, g: 51, b: 51, a: 1.0)
        iconName.textAlignment = NSTextAlignment.center
        iconName.font = UIFont.italicSystemFont(ofSize: 15.0)
        contentView.addSubview(iconName)
        alertLabel.backgroundColor = UIColor.red
        alertLabel.clipsToBounds = true;
        alertLabel.layer.cornerRadius = 10;
        alertLabel.layer.masksToBounds = true;
        alertLabel.adjustsFontSizeToFitWidth = true;
        alertLabel.font = UIFont.systemFont(ofSize: 9.0)
        alertLabel.tintColor = UIColor.white
        alertLabel.textColor = UIColor.white
        alertLabel.textAlignment = NSTextAlignment.center
        
        contentView.addSubview(alertLabel)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        setUpViews()
    }
    
    func setUpViews() {
        
        iconImage.snp.makeConstraints { (maker) in
            maker.width.equalTo(45)
            maker.height.equalTo(45)
            maker.center.equalTo(self)
            maker.centerY.equalTo(self).offset(-6.5)
        }
        
        iconName.snp.makeConstraints { (maker) in
            maker.top.equalTo(iconImage.snp.bottom).offset(5)
            maker.height.equalTo(12)
            maker.width.equalTo(self)
            maker.left.equalTo(self)
        }
        
        alertLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(iconImage.snp.top).offset(-4)
            maker.left.equalTo(iconImage.snp.right).offset(-4)
            maker.width.equalTo(20)
            maker.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("SquareCollectionViewCell 初始化没有成功！")
    }
    
}
