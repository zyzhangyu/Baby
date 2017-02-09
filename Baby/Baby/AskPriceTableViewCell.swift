//
//  AskPriceTableViewCell.swift
//  Baby
//
//  Created by ZhangYu on 2017/2/7.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class AskPriceTableViewCell: UITableViewCell {

    var button = UIButton.init(type: UIButtonType.custom)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        button.setBackgroundImage(UIImage.init(named: "yb_gbtn_green"), for: UIControlState.normal)
        button.setTitle("开始延保询价", for: UIControlState.normal)
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.top.equalTo(5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
        
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
