//
//  HomeCollectionViewCell.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/22.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit



//这里我准备写一个协议，让Controller成为协议的执行者，这样符合MVC
protocol HomeCollectionViewCellDelegate:NSObjectProtocol {
    
    func clickImageview(_ string: String?)
}


class HomeCollectionViewCell: UICollectionViewCell {

    var rects:[CGRect] = [CGRect]()
    var imageViews:[UIImageView] =  [UIImageView]()
    var delegate:HomeCollectionViewCellDelegate?
    
    var model:HomeSectionItemModel? {
        
        didSet{
            
            contentView.subviews.map{$0.removeFromSuperview()}
            
            let itemArrat =  model?.rows;
            
            var x:CGFloat = 0;
            var y:CGFloat = 0;
            var currentRow = 1;
            var lastHeight:CGFloat = 0;
            for var array in itemArrat! {
                
                x = 0;
                
                
                for index in 0..<array.count {
                    let height = ZYConstants.SCREENWIDTH/ZYCoreUtils.StringToCGFloat(str:array[index].BlockWithHeightProportionSum!)
                    let width = height * ZYCoreUtils.StringToCGFloat(str: array[index].BlockWithHeightProportion!)
                    
                    
                    if currentRow != Int(array[index].VersionAreaRow!) {
                        currentRow = Int(array[index].VersionAreaRow!)
                        y += lastHeight;
                    }
                    let rect = CGRect.init(x: x, y: y, width: width, height: height)
                    
                    x += width;
                    rects.append(rect)
                    let imageView = UIImageView.init(frame: rect)
                    imageView.sd_setImage(with: URL.init(string: array[index].BlockBackgroupImgUrl!))
                    imageView.isUserInteractionEnabled = true
                    imageViews.append(imageView)
                    self.contentView.addSubview(imageView)
                    lastHeight = height;
                    let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(HomeCollectionViewCell.clickImageView(_:)))
                    tap.blockURL = array[index].BlockUrl
                    imageView.addGestureRecognizer(tap)
                    
                }
            }
        }
    }
    
    
    func clickImageView(_ tap:UITapGestureRecognizer) {
        
        delegate?.clickImageview(tap.blockURL)
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white

    }
    
    func makeCornerRadius(imageView:UIImageView) {
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.purple.cgColor
        imageView.layer.borderWidth = 1.5
        imageView.backgroundColor = UIColor.cyan
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UITapGestureRecognizer {
    
    private struct AssociatedKeys {
        static var kTapBlockURL = "kBlockURL"
    }
    
    var blockURL:String? {
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kTapBlockURL, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.kTapBlockURL) as! String?
        }
    }
    
}
