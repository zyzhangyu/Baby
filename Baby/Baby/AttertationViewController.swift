//
//  AttertationViewController.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/25.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class AttertationViewController: BaseViewController {

    
    @IBOutlet weak var bannnerImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "认证车主"
        bannnerImageView.sd_setImage(with: URL.init(string: "http://images.chewawa.com.cn/inapp/V40-2/vippagetitle.png"))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    @IBAction func lookProtocol(_ sender: UITapGestureRecognizer) {
        
        print("lookProtocol")
    }
    
    override func clickBackBarButton(){
        
        self.navigationController?.popViewController(animated: true)
    }

}
