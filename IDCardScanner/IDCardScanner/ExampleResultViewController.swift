//
//  ExampleResultViewController.swift
//  Example
//
//  Created by miyasaka on 2020/07/30.
//

import UIKit

class ExampleResultViewController: UIViewController {
    @IBOutlet var resultLabel: UILabel!

    @IBAction func startButton(_ sender: UIButton) {

        let vc = IDCardScannerViewController(delegate: self)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExampleResultViewController: IDCardScannerViewControllerDelegate {
    
    /// 隐藏掉 摄像头界面
    func idCardScannerViewControllerDidCancel(_ viewController: IDCardScannerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        print("cancel")
    }
 
    /// 如果失败  也隐藏
    func idCardScannerViewController(_ viewController: IDCardScannerViewController, didErrorWith error: IDCardScannerError) {
        print(error.errorDescription ?? "")
        resultLabel.text = error.errorDescription
        viewController.dismiss(animated: true, completion: nil)
    }

     func idCardScannerViewController(_ viewController: IDCardScannerViewController, didFinishWith card: IDCard) {
        viewController.dismiss(animated: true, completion: nil)
                
        print("最终返回的card",card)

        let text = [card.cardName, card.cardNation, card.cardAddress, card.cardNumber]
            .compactMap { $0 }
            .joined(separator: "\n")
        resultLabel.text = text
        print("\(card)")
    }
}
