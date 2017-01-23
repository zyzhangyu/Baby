//
//  HotRecommendCollectionViewCell.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/20.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class HotRecommendCollectionViewCell: UICollectionViewCell {
    
//    let sentryView:UIView! = UIView.init()
//    let topTitle:UILabel! = UILabel.init()
//    let line:UIView! = UIView.init()
    var topImageView:UIImageView! = UIImageView.init()
    let leftImageView:UIImageView! = UIImageView.init()
    let rightImageView:UIImageView! = UIImageView.init()
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
//        sentryView.backgroundColor = UIColor.red
//        
//        topTitle.textColor = UIColor.gray
//        topTitle.textAlignment = NSTextAlignment.left
//        topTitle.font = UIFont.systemFont(ofSize: 13.0)
//        topTitle.text = "热门推荐"
//        topTitle.backgroundColor = UIColor.cyan
//        
//        line.backgroundColor = UIColor.gray
        
        
        topImageView.image = UIImage.init(named: "serviceicon_engine")
        leftImageView.image = UIImage.init(named: "serviceicon_engine")
        rightImageView.image = UIImage.init(named: "serviceicon_road")
        
        makeCornerRadius(imageView: topImageView)
        makeCornerRadius(imageView: leftImageView)
        makeCornerRadius(imageView: rightImageView)
        
//        self.contentView.addSubview(sentryView)
//        self.contentView.addSubview(topTitle)
//        self.contentView.addSubview(line)
        self.contentView.addSubview(topImageView)
        self.contentView.addSubview(leftImageView)
        self.contentView.addSubview(rightImageView)
    }
    
    func makeCornerRadius(imageView:UIImageView) {
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.purple.cgColor
        imageView.layer.borderWidth = 1.5
        imageView.backgroundColor = UIColor.cyan
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        
//        sentryView.snp.makeConstraints { (make) in
//            make.top.equalTo(9)
//            make.left.equalTo(15)
//            make.width.equalTo(5)
//            make.height.equalTo(26)
//        }
//        
//        topTitle.snp.makeConstraints { (make) in
//            
//            make.top.equalTo(5)
//            make.left.equalTo(20)
//            make.height.equalTo(35)
//            make.width.equalTo(320)
//        }
//        
//        
//        
//        line.snp.makeConstraints { (make) in
//            
//            make.top.equalTo(topTitle.snp.bottom).offset(1 )
//            make.left.equalTo(0)
//            make.width.equalTo(ZYConstants.SCREENWIDTH)
//            make.height.equalTo(2)
//        }
        
        topImageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(ZYConstants.SCREENWIDTH)
            make.height.equalTo(60)
        }
        
        leftImageView.snp.makeConstraints { (make) in
            make.top.equalTo(topImageView.snp.bottom).offset(2)
            make.left.equalTo(15)
            make.width.equalTo(ZYConstants.cellImageViewWidth)
            make.height.equalTo(100)
        }
        
        rightImageView.snp.makeConstraints { (make) in
            
            make.top.equalTo(leftImageView)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.width.equalTo(ZYConstants.cellImageViewWidth)
            make.height.equalTo(100)
        }
    }
    
}
