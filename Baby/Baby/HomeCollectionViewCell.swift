//
//  HomeCollectionViewCell.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/22.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit

//我现在还不会这么写闭包传值，但是大概的样子还是知道的！
typealias clickImageViewClosure = () -> Void

//这里我准备写一个协议，让Controller成为协议的执行者，这样符合MVC
protocol HomeCollectionViewCellDelegate:NSObjectProtocol {
    
    func clickImageview(_ model: HomeItemModel)
}


class HomeCollectionViewCell: UICollectionViewCell {

    var rects:[CGRect] = [CGRect]()
    var imageViews:[UIImageView] =  [UIImageView]()
    
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
                    let tap:UIGestureRecognizer = UIGestureRecognizer.init(target: self, action: #selector(HomeCollectionViewCell.clickImageView))
                    imageView.addGestureRecognizer(tap)
                }
            }
        }
    }
    
    
    func clickImageView() {
        
        print("点击了一个ImageView")
        //???? 现在控制台显示的是，collectionview的代理方法，没有运行到这个新加的方法，我要研究一会了！
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
