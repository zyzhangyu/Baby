//
//  MainViewController.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/18.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController{
    
    var left:HomeViewController!
    var middle:GoodDriverViewController!
    var right:MyViewController!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
        setupTabbar()
    }
    
    
    /*
     // MARK: - 设置Tababr
     */
    func setupTabbar(){
        
        var navigation:UINavigationController
        
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.init(red: 138.0/255.0, green: 209.0/255.0, blue: 33/255.0, alpha: 1.0)

        if left == nil{
            
            left = HomeViewController()
            left.tabBarItem = UITabBarItem.init(title:"首页",
                                                image: UIImage.init(named: "micon_home"),
                                                selectedImage: UIImage.init(named: "micon_home"))
            navigation = UINavigationController.init(rootViewController: left)
            self.addChildViewController(navigation)
        }
        
        if middle == nil {
            
            middle = GoodDriverViewController()
            middle.tabBarItem = UITabBarItem.init(title: "",
                                                  image: UIImage.init(named: "gooddriver_off")?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: UIImage.init(named: "gooddriver_on")?.withRenderingMode(.alwaysOriginal))
            middle.tabBarItem.imageInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: -5, right: 0)
            navigation = UINavigationController.init(rootViewController: middle)
            self.addChildViewController(navigation)
        }
        
        if right == nil {
            
            right = MyViewController()
            right.tabBarItem = UITabBarItem.init(title: "我的",
                                                 image: UIImage.init(named: "micon_mine"),
                                                 selectedImage: UIImage.init(named: "micon_mine"))
            navigation = UINavigationController.init(rootViewController: right)
            self.addChildViewController(navigation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MainViewController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let selectVC = tabBarController.selectedViewController
        
        if selectVC!.isEqual(viewController) {
            
            let navigationController = viewController as! UINavigationController
            let rootViewController = navigationController.viewControllers[0]
            
            if rootViewController.isKind(of: left.classForCoder) {
                print("双击了首页...")
            } else if rootViewController.isKind(of: middle.classForCoder) {
                print("双击了好司机...")
            } else if rootViewController.isKind(of: right.classForCoder) {
                print("双击了我的..")
            }
        }
        
        return true
    }
}
