//
//  DiscountCalculatorViewController.swift
//  Baby
//
//  Created by ZhangYu on 2017/2/6.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class DiscountCalculatorViewController: BaseViewController {

    @IBOutlet weak var tapImageView: UIImageView!
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var introduceButton: UIButton!
    
    
    let pick = UIPickerView.init()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "添加车辆"
        
        
        
        aTableView.register(DiscountCalculatorTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        let titleImageView = UIImageView.init()
        titleImageView.image = UIImage.init(named: "gooddriver_text_prizecalc")
        tapImageView.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(tapImageView)
            make.top.equalTo(5)
            make.width.equalTo(ZYConstants.SCREENWIDTH)
            make.height.equalTo(120)
        }
        
        let titleLabel = UILabel.init()
        titleLabel.text = "请先填写车辆信息"
        titleLabel.font = UIFont.init(name: "Avenir Heavy", size: 27.0)
        titleLabel.textColor = ZYCoreUtils.BabyColor(255, g: 112, b: 44, a: 1.0)
        titleLabel.textAlignment = NSTextAlignment.center
        tapImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(titleImageView.snp.bottom).offset(-30)
            make.centerX.equalTo(tapImageView)
            make.width.equalTo(ZYConstants.SCREENWIDTH-50)
            make.height.equalTo(50)
        }
        
        let line = UIImageView.init()
        line.image = UIImage.init(named: "line_fading")
        tapImageView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(0)
            make.width.equalTo(ZYConstants.SCREENWIDTH)
            make.height.equalTo(1)
        }
        
        
        
    }
    
    
    override func clickBackBarButton() {
        navigationController?.popViewController(animated: true)
    }

    
    //计算奖金
    @IBAction func clickBonusCalculation(_ sender: UIButton) {
    }
    //购买延保
    @IBAction func buyProlong(_ sender: UIButton) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DiscountCalculatorViewController : UITableViewDelegate, UITableViewDataSource {

    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier="cell";
        var cell=tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        }
        
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
            case 3:
                cell.accessoryType=UITableViewCellAccessoryType.none
                cell.txt = "最后一次商业驾驶车险购买价"
                cell.valueStr = "10000元"
                cell.rtStr = nil
                cell.rbStr = nil

            default:
                cell.accessoryType=UITableViewCellAccessoryType.none
                
            }
        }
        
        return cell!
    }
    
    
    //段数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    //行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60.0
    }
    
    //选中cell时触发这个代理
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("indexPath.row = SelectRow第\(indexPath.row)行")
        
        
        switch indexPath.row {
        case 0:
            print("aa")

        case 1:
//            pick.backgroundColor = UIColor.white
//            pick.frame = CGRect.init(x: 0, y: ZYConstants.SCREENHEIGHT-64-49-200, width: ZYConstants.SCREENWIDTH, height: 200)
//            pick.delegate = self
//            pick.dataSource = self
//            view.addSubview(pick)
//            pick.showsSelectionIndicator = true
//            pick.selectRow(0, inComponent: 0, animated: true)
//            pick.selectRow(0, inComponent: 1, animated: true)
//            pick.selectRow(0, inComponent: 2, animated: true)
            print("vv")
        case 2:
            print("aaa")

        case 3:
            print("aaa")
        default:
            print("aaa")

        }
    }
    
    
    
    

}

extension DiscountCalculatorViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    
    /* 设置选择框的列数 */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    /* 设置行数 */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    /* 使用系统的view时， 返回要显示的文字 */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(component) --- \(row)"
    }
    
     /* 检查响应选项的选择状态 */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print("click \(component) --- \(row)")
    }
    
    //列宽
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return ZYConstants.SCREENWIDTH/3.0 - 15
    }
    
    
    //行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    
    
}
