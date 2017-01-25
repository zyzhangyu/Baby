//
//  HomeBannerViewCollectionReusableView.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/19.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit
import SnapKit
class HomeBannerViewCollectionReusableView: UICollectionReusableView {
    
    var headerSCView:UIScrollView!
    var centerImageView:UIImageView!
    var leftImageView:UIImageView!
    var rightImageView:UIImageView!
    var pageControl:UIPageControl!
    var bannerIndex:NSNumber!
    var timer:Timer?
    
    fileprivate let HeadViewHeight:CGFloat = 200.0
    
    let images = ["ybsplash1", "ybsplash2", "ybsplash3", "ybsplash4"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createHeaderview()
        runTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        headerSCView.snp.makeConstraints({ (make)->Void in
            
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        })
        
        pageControl.snp.makeConstraints({(make)->Void in
            
            make.top.equalTo(self.snp.bottom).offset(-30)
            make.left.equalTo(self.snp.right).offset(-60)
            make.width.equalTo(40)
            make.height.equalTo(25)
        })
        
        headerSCView.contentSize = CGSize.init(width: ZYConstants.SCREENWIDTH * CGFloat(3.0),
                                               height: HeadViewHeight)
        headerSCView.contentOffset = CGPoint.init(x: ZYConstants.SCREENWIDTH, y: 0)
    }
    
    
    func createHeaderview() {
        
        if headerSCView == nil {
            
            headerSCView = UIScrollView()
            headerSCView.isPagingEnabled = true
            headerSCView.isUserInteractionEnabled = true
            headerSCView.delegate = self
            headerSCView.bounces = false
            headerSCView.showsHorizontalScrollIndicator = false
            headerSCView.showsVerticalScrollIndicator = false
            headerSCView.backgroundColor = UIColor.red
            self.addSubview(headerSCView)
        }
        
        let cRect = CGRect.init(x: ZYConstants.SCREENWIDTH, y: 0, width: ZYConstants.SCREENWIDTH, height: HeadViewHeight)
        centerImageView = UIImageView.init(frame: cRect)
        centerImageView.backgroundColor = UIColor.yellow
        headerSCView.addSubview(centerImageView)
        
        let lRect = CGRect.init(x: 0, y: 0, width: ZYConstants.SCREENWIDTH, height: HeadViewHeight)
        leftImageView = UIImageView.init(frame: lRect)
        leftImageView.backgroundColor = UIColor.purple
        headerSCView.addSubview(leftImageView)
        
        let rRect = CGRect.init(x: ZYConstants.SCREENWIDTH * CGFloat(2.0), y: 0, width: ZYConstants.SCREENWIDTH, height: HeadViewHeight)
        rightImageView = UIImageView.init(frame: rRect)
        rightImageView.backgroundColor = UIColor.orange
        headerSCView.addSubview(rightImageView)
        
        if pageControl == nil {
            
            pageControl = UIPageControl()
            pageControl.addTarget(self, action: #selector(pageAction(_:)), for: UIControlEvents.touchUpInside)
            pageControl?.numberOfPages = 4
            pageControl.currentPage = 0
            pageControl.currentPageIndicatorTintColor = UIColor.cyan

            self.addSubview(pageControl!)
        }
        
        bannerIndex = 0
        setInfoByCurrentImageIndex(bannerIndex)
        
    }

    
    func runTimer() {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(HomeBannerViewCollectionReusableView.changePage), userInfo: nil, repeats: true)
    }
    
    func changePage() {
        
        UIView.animate(withDuration: 0.4,
                       animations: { () -> Void in
                        
                        self.headerSCView.contentOffset.x = ZYConstants.SCREENWIDTH * 2},
                       completion: {(finished:Bool) -> Void in
                        
                        self.scrollViewDidEndDecelerating(self.headerSCView)
        })
    }
    
    func pageAction(_ sender:AnyObject) {
        
        headerSCView.contentOffset = CGPoint.init(x: ZYConstants.SCREENWIDTH, y: 0)
        bannerIndex = NSNumber.init(value: pageControl.currentPage)
        loadImage()
    }
    
    func loadImage() {
        
        if headerSCView!.contentOffset.x > ZYConstants.SCREENWIDTH {
            
            bannerIndex = (bannerIndex.intValue + 1 + 4) % 4 as NSNumber!
        } else if headerSCView.contentOffset.x < ZYConstants.SCREENWIDTH {
            bannerIndex = (bannerIndex.intValue - 1 + 4) % 4 as NSNumber!
        }
        setInfoByCurrentImageIndex(bannerIndex)
    }
    
    func setInfoByCurrentImageIndex(_ index: NSNumber) {
        
        pageControl.currentPage = index.intValue;
        centerImageView?.image = UIImage.init(named: images[index.intValue])
        leftImageView.image =  UIImage.init(named: images[(index.intValue - 1 + 4) % 4])
        rightImageView.image = UIImage.init(named: images[(index.intValue + 1 + 4) % 4])
    }


}

extension HomeBannerViewCollectionReusableView : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImage()
        headerSCView.contentOffset = CGPoint.init(x: ZYConstants.SCREENWIDTH, y: 0)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        perform(#selector(HomeBannerViewCollectionReusableView.runTimer), with: nil, afterDelay: 1.0)
    }
    
}


