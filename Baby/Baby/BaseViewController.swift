//
//  BaseViewController.swift
//  Baby
//
//  Created by ZhangYu on 2017/2/4.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
        navigationController?.navigationBar.barTintColor = ZYConstants.navigationBarTintColor
        navigationController?.navigationBar.shadowImage = UIImage.init()
 
        navigationItem.leftBarButtonItem = ZYCoreUtils.setupBackBarButton(self);
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.init(name: "Heiti SC", size: 15)!]
        
        
        
        self.edgesForExtendedLayout=[]
        self.extendedLayoutIncludesOpaqueBars=false;
        self.automaticallyAdjustsScrollViewInsets=false;
       /*
         .
         var attributes = [UITextAttributeTextColor:UIColor.white,
         :]
         
         
         self.navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont("字体名", ofSize: 15)]
         

         
         
         */
        
    
    
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func clickBackBarButton(){
        print("abc abc abc")
    }


    /*
     
     
     override func preferredStatusBarStyle() -> UIStatusBarStyle {
     
     return UIStatusBarStyle.LightContent
     
     }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
