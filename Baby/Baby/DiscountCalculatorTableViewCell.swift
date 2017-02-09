//
//  DiscountCalculatorTableViewCell.swift
//  Baby
//
//  Created by ZhangYu on 2017/2/6.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class DiscountCalculatorTableViewCell: UITableViewCell {
    
    var txtLabel:UILabel = UILabel.init()
    var expletoryLabel:UILabel = UILabel.init()
    var rightTopLabel:UILabel = UILabel.init()
    var rightBottomLabel = UILabel.init()
    var buyButton = UIButton.init(type: UIButtonType.custom)
    var txt:String? {
        didSet{
            txtLabel.text = txt;
        }
    }
    
    
    var valueStr:String? {
        didSet{
            expletoryLabel.text = valueStr
            expletoryLabel.isHidden = false
        }
    }

    var rtStr:String? {
        didSet{
            rightTopLabel.text = rtStr
            rightTopLabel.isHidden = false
        }
    }
    
    var rbStr:String? {
        didSet{
            rightBottomLabel.text = rbStr
            rightBottomLabel.isHidden = false
        }
    }


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        contentView.addSubview(txtLabel)
        txtLabel.font = UIFont.systemFont(ofSize: 15.0)
        txtLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(10)
            make.height.equalTo(contentView)
            make.width.equalTo(220)
        })
        
        expletoryLabel.isHidden = true
        expletoryLabel.font = UIFont.systemFont(ofSize: 15.0)
        expletoryLabel.textAlignment = NSTextAlignment.right
        contentView.addSubview(expletoryLabel)
        expletoryLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(-5)
            make.height.equalTo(contentView)
            make.width.equalTo(200)
        })
        
        
        
        
        rightTopLabel.isHidden = true
        rightTopLabel.font = UIFont.systemFont(ofSize: 12.0)
        rightTopLabel.textAlignment = NSTextAlignment.right

        contentView.addSubview(rightTopLabel)
        rightTopLabel.snp.makeConstraints { (make) in
            make.top.equalTo(3)
            make.right.equalTo(contentView).offset(-5)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        rightBottomLabel.isHidden = true
        rightBottomLabel.textAlignment = NSTextAlignment.right
        rightBottomLabel.font = UIFont.systemFont(ofSize: 12.0)
        contentView.addSubview(rightBottomLabel)
        rightBottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightTopLabel.snp.bottom).offset(5)
            make.right.equalTo(contentView).offset(-5)
            make.width.equalTo(250)
            make.height.equalTo(30)
        }
        
    }

}
