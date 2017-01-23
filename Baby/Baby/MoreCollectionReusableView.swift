//
//  MoreCollectionReusableView.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/23.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class MoreCollectionReusableView: UICollectionReusableView {
    
    let sentryView:UIView! = UIView.init()
    let topTitle:UILabel! = UILabel.init()
    let line:UIView! = UIView.init()

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        sentryView.backgroundColor = UIColor.red
        
        topTitle.textColor = UIColor.gray
        topTitle.textAlignment = NSTextAlignment.left
        topTitle.font = UIFont.systemFont(ofSize: 13.0)
        topTitle.text = "更多功能"
        topTitle.backgroundColor = UIColor.cyan
        
        line.backgroundColor = UIColor.gray

        self.addSubview(sentryView)
        self.addSubview(topTitle)
        self.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        
        sentryView.snp.makeConstraints { (make) in
            make.top.equalTo(9)
            make.left.equalTo(15)
            make.width.equalTo(5)
            make.height.equalTo(26)
        }
        
        topTitle.snp.makeConstraints { (make) in
            
            make.top.equalTo(5)
            make.left.equalTo(20)
            make.height.equalTo(35)
            make.width.equalTo(320)
        }
        
        line.snp.makeConstraints { (make) in
            
            make.top.equalTo(topTitle.snp.bottom).offset(1 )
            make.left.equalTo(0)
            make.width.equalTo(ZYConstants.SCREENWIDTH)
            make.height.equalTo(2)
        }

    }
    
    

    
}
