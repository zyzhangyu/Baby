//
//  WaWaViewController.swift
//  Baby
//
//  Created by 张宇 on 2017/2/12.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

class WaWaViewController: GDWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        button.setBackgroundImage(UIImage.init(named: "ticon_back"), for: UIControlState.normal)
        button.setTitleColor(ZYConstants.navigationBackBarBttonColor, for: UIControlState.normal)
        button.setTitleColor(ZYConstants.navigationBackBarBttonColor, for: UIControlState.highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(WaWaViewController.clickBackBarButton), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem.init(customView: button)
        navigationItem.leftBarButtonItem = barButton
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.init(name: "Heiti SC", size: 15)!]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func clickBackBarButton(){
        
        self.navigationController?.popViewController(animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    func webViewController(_ webViewController: GDWebViewController, didChangeTitle newTitle: NSString?) {
//        navVC.navigationBar.topItem?.title = newTitle as? String
//    }
//    
//    func webViewController(_ webViewController: GDWebViewController, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
//        if let URL = navigationAction.request.url as URL?,
//            let host = URL.host as NSString?
//        {
//            let testSubdomain = "." + gHost
//            if host as String == gHost || host.range(of: testSubdomain, options: .caseInsensitive).location != NSNotFound {
//                decisionHandler(.allow)
//                return
//            }
//        }
//        
//        print(navigationAction.request.url?.host)
//        decisionHandler(.cancel)
//    }
//    
//    func webViewController(_ webViewController: GDWebViewController, didFinishLoading loadedURL: URL?) {
//        if gShowAlertOnDidFinishLoading {
//            webViewController.evaluateJavaScript("alert('Loaded!')", completionHandler: nil)
//        }
//    }

}

extension WaWaViewController:GDWebViewControllerDelegate{
    // MARK: GDWebViewControllerDelegate Methods
    

    
}
