//
//  MyViewController.swift
//  Baby
//
//  Created by Liuchun on 2017/2/13.
//  Copyright © 2017年 Liuchun. All rights reserved.
//

import UIKit

var kSize=UIScreen.main.bounds;

var dataTable:UITableView!
var itemCouponStringArr=["我的消息","加油优惠券","延保优惠券","加油卡管理"] , itemOrderStringArr = ["加油订单","延保订单","道路救援订单"] ,itemMoreStringArr = ["问题反馈","分享车娃娃","关于车娃娃"]




class MyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //调用table方法
        makeTable()
        
        // Do any additional setup after loading the view.
    }
    
    
    func makeTable (){
        dataTable=UITableView.init(frame: CGRect(x: 0.0, y: 0.0, width: kSize.width, height: kSize.height), style:.plain)
        dataTable.delegate=self;//实现代理
        dataTable.dataSource=self;//实现数据源
        dataTable.showsVerticalScrollIndicator = false
        dataTable.showsHorizontalScrollIndicator = false
        self.view.addSubview(dataTable)
        
        //tableFooter
        dataTable.tableFooterView = UIView.init()
    }
    
    //段数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return itemCouponStringArr.count
        }else if(section == 1){
            return itemOrderStringArr.count
        }else{
            return itemMoreStringArr.count
        }
        
    }
    
    //行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         let indentifier = "CellA"
         var cell:TableViewCellA! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? TableViewCellA
         if cell == nil {
         cell=TableViewCellA(style: .default, reuseIdentifier: indentifier)
         }
         
         
         return cell!
         */
        
        let identifier="identtifier";
        var cell=tableView.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier);
        }
        
        
        if(indexPath.section == 0){
            cell?.textLabel?.text = itemCouponStringArr[indexPath.row];
            
        }else if(indexPath.section == 1){
            cell?.textLabel?.text = itemOrderStringArr[indexPath.row];
            
        }else{
            cell?.textLabel?.text = itemMoreStringArr[indexPath.row];
            
        }
        
        cell?.detailTextLabel?.text = "待添加内容";
        cell?.detailTextLabel?.font = UIFont .systemFont(ofSize: CGFloat(13))
        cell?.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        
        return cell!
    }
    
    //选中cell时触发这个代理
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("indexPath.row = SelectRow第\(indexPath.row)行")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
