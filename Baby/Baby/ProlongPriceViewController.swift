//
//  ProlongPriceViewController.swift
//  Baby
//
//  Created by ZhangYu on 2017/2/7.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class ProlongPriceViewController: BaseViewController {
    
    let bannerImageView = UIImageView.init()
    let aTableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "延保询价"
        steupUI()
    }
    
    func steupUI() {
        
        bannerImageView.image = UIImage.init(named: "yanbao_ad")
        view.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(ZYConstants.SCREENWIDTH)
            make.height.equalTo(120)
        }
        
        aTableView.delegate = self
        aTableView.dataSource = self
        aTableView.register(DiscountCalculatorTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        aTableView.register(PriceRecordTableViewCell.classForCoder(), forCellReuseIdentifier: "price")
        aTableView.register(AskPriceTableViewCell.classForCoder(), forCellReuseIdentifier: "askPriceButton")
        view.addSubview(aTableView)
        aTableView.snp.makeConstraints { (make) in
            make.top.equalTo(bannerImageView.snp.bottom)
            make.left.equalTo(0)
            make.width.equalTo(ZYConstants.SCREENWIDTH)
            make.height.equalTo(550)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func clickBackBarButton() {
        navigationController?.popViewController(animated: true)
    }

}

extension ProlongPriceViewController:UITableViewDelegate, UITableViewDataSource{
    
    //行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60.0

        } else {
            return 80
        }
        
    }
    //section数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //section里面行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else {
            return 20
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let head = UIView.init()
            head.frame = CGRect.init(x: 0, y: 0, width: ZYConstants.SCREENWIDTH, height: 20)
            head.backgroundColor = UIColor.black
            
            let icon = UIImageView.init(frame: CGRect.init(x: 10, y: 0, width: 20, height: 20))
            icon.image = UIImage.init(named: "minicon_car")
            head.addSubview(icon)
            
            let txt = UILabel.init(frame: CGRect.init(x: 30, y: 0, width: 100, height: 20))
            txt.textColor = UIColor.white
            txt.font = UIFont.systemFont(ofSize: 13.0)
            txt.text = "车辆信息"
            head.addSubview(txt)
            return head
        } else {
            let head = UIView.init()
            head.frame = CGRect.init(x: 0, y: 0, width: ZYConstants.SCREENWIDTH, height: 20)
            head.backgroundColor = ZYCoreUtils.BabyColor(248, g: 248, b: 248, a: 1)
            
            let txt = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 20))
            txt.textColor = ZYCoreUtils.BabyColor(180, g: 180, b: 180, a: 1)
            txt.font = UIFont.systemFont(ofSize: 13.0)
            txt.text = "我的询价记录"
            head.addSubview(txt)
            return head
        }
        
     
    }
    
    //cell.init
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let identifier="cell";
        var cell=tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        }
        
        
        switch indexPath.section {
        case 0:
                if let cell = cell as? DiscountCalculatorTableViewCell{
                    switch indexPath.row {
                    case 0:
                        cell.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
                        cell.txt = "车辆品牌类型"
                        cell.valueStr = nil
                        cell.rtStr = "北京汽车 北京40"
                        cell.rbStr = "2016款 北京40 2.0T 手动四驱尊贵版"
                    case 1:
                        cell.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
                        cell.txt = "登记时间地点"
                        cell.valueStr = nil
                        cell.rtStr = "重庆 重庆"
                        cell.rbStr = "2017年02月02日"
                        
                    case 2:
                        cell.accessoryType=UITableViewCellAccessoryType.none
                        cell.txt = "当前行驶里程"
                        cell.valueStr = "100公里"
                        cell.rtStr = nil
                        cell.rbStr = nil
                    default:
                        cell.accessoryType=UITableViewCellAccessoryType.none
                        
                    }
                    
                    
                    
                }
            
                if indexPath.row == 3 {
                    cell = tableView.dequeueReusableCell(withIdentifier: "askPriceButton")
                    if(cell == nil){
                        cell=UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "askPriceButton")
                    }
                    if let cell = cell as? AskPriceTableViewCell{
                    }
                }
            
            
            
            
            
            
            
            
            
            
            
            
        case 1:
            
            cell = tableView.dequeueReusableCell(withIdentifier: "price")
            if(cell == nil){
                cell=UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "price")
            }
            
            if let cell = cell as? PriceRecordTableViewCell{
                switch indexPath.row {
                case 0:
                    cell.icon.image = UIImage.init(named: "icon40")
                    cell.topLabel.text = "奔驰 奔驰E级 E200 运动型"
                    cell.middleLabel.text = "2017款 奔驰 奔驰E级 E200 运动型"
                    cell.bottomLabel.text = "2017年1月7日北京"
                case 1:
                    cell.icon.image = UIImage.init(named: "icon40")
                    cell.topLabel.text = "阿斯顿.马丁 Rapide"
                    cell.middleLabel.text = "2010款 阿斯顿马丁 Rapide 基本型"
                    cell.bottomLabel.text = "2013年12月31日 北京 北京"
                default:
                    cell.accessoryType=UITableViewCellAccessoryType.none
                }
            }
        default:
            print("这里除了什么状况？")
        }
        return cell!
    }
    
    
    
}
