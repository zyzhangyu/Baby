//
//  AttertationViewController.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/25.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class AttertationViewController: UIViewController {

    @IBOutlet weak var bannnerImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannnerImageView.sd_setImage(with: URL.init(string: "http://images.chewawa.com.cn/inapp/V40-2/vippagetitle.png"))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    @IBAction func lookProtocol(_ sender: UITapGestureRecognizer) {
        
        print("lookProtocol")
    }

    @IBAction func clickBanner(_ sender: UITapGestureRecognizer) {
        print("clickBanner")
    }
}
