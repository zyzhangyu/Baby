//
//  PriceRecordTableViewCell.swift
//  Baby
//
//  Created by ZhangYu on 2017/2/7.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class PriceRecordTableViewCell: UITableViewCell {
    
    var icon = UIImageView.init()
    var topLabel = UILabel.init()
    var middleLabel = UILabel.init()
    var bottomLabel = UILabel.init()
    var buyButton = UIButton.init()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        
        
        
        
        
        buyButton.setBackgroundImage(UIImage.init(named: "yb_gbtn_green"), for: UIControlState.normal)
        buyButton.setTitle("继续购买", for: UIControlState.normal)
        
        topLabel.font = UIFont.systemFont(ofSize: 13.0)
        middleLabel.font = UIFont.systemFont(ofSize: 12.0)
        bottomLabel.font = UIFont.systemFont(ofSize: 12.0)

        
        contentView.addSubview(icon)
        contentView.addSubview(topLabel)
        contentView.addSubview(middleLabel)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(buyButton)
        
        
        
        
        icon.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(icon.snp.right).offset(20)
            make.height.equalTo(25)
        }
        
        middleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(5)
            make.left.equalTo(topLabel)
            make.height.equalTo(20)
        }
        
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(middleLabel.snp.bottom).offset(5)
            make.left.equalTo(topLabel)
            make.height.equalTo(20)
        }
        
        buyButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
