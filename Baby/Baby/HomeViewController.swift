//
//  HomeViewController.swift
//  Baby
//
//  Created by ZhangYu on 2017/1/18.
//  Copyright © 2017年 ZhangYu. All rights reserved.
//

import UIKit
import SnapKit
import ObjectMapper
import SDWebImage
class HomeViewController: UIViewController {
    // this view is not changed
    var zyCollectionView:UICollectionView!
    fileprivate let HeadViewHeight:CGFloat = 200.0
    var response:HomeResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        let layout = UICollectionViewFlowLayout.init()
        var rect = self.view.bounds;
        rect.origin.y = 64;
        rect.size.height = ZYConstants.SCREENHEIGHT - 64 - 49;
        zyCollectionView = UICollectionView.init(frame: rect, collectionViewLayout: layout)
        zyCollectionView.backgroundColor = UIColor.cyan
        zyCollectionView.delegate = self
        zyCollectionView.dataSource = self
        zyCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: ZYConstants.CellID)
        zyCollectionView.register(HomeBannerViewCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        self.view.addSubview(zyCollectionView)
        
        let path = Bundle.main.path(forResource: "Home", ofType: "")
        let url = URL.init(fileURLWithPath: path!)
        do {
            
            let data = try Data.init(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            response = Mapper<HomeResponse>.init().map(JSON: json)
        } catch let error as Error! {
            print("首页数据读取失败!", error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    //设定页眉的全局尺寸，需要注意的是，根据滚动方向不同，header和footer的width和height中只有一个会起作用。如果要单独设置指定区内的页面和页脚尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            return CGSize.init(width: ZYConstants.SCREENWIDTH, height: 150)
        }
        return CGSize.zero
    }
    
    //设定页脚的全局尺寸，需要注意的是，根据滚动方向不同，header和footer的width和height中只有一个会起作用。如果要单独设置指定区内的页面和页脚尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize.zero
    }
    
    /**
     *  设定指定区内Cell的最小行距
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    /**
     *  指定区内Cell的最小间距
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    /**
     *  指定区的内边距
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        var model:HomeSectionItemModel = (response?.data![indexPath.section])!
        let itemArrat =  model.rows;
        
        var y:CGFloat = 0;
        var currentRow = 1;
        var lastHeight:CGFloat = 0;
        for var array in itemArrat! {
            
            for index in 0..<array.count {
                let height = ZYConstants.SCREENWIDTH/ZYCoreUtils.StringToCGFloat(str:array[index].BlockWithHeightProportionSum!)
                if currentRow != Int(array[index].VersionAreaRow!) {
                    currentRow = Int(array[index].VersionAreaRow!)
                    y += lastHeight;
                }
                lastHeight = height;
            }
        }
        
        return CGSize.init(width: ZYConstants.SCREENWIDTH, height: lastHeight + y)
    }
    
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print( "didSelectItemAt" +   String(indexPath.section))
        
        switch indexPath.section {
        case 0:
            print("0000000000")
        default:
            print("default,default,default.")
        }
    }
    
    /**
     *  返回collection view里区(section)的个数，如果没有实现该方法，将默认返回1
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return (response?.data?.count)!
    }
    
    /**
     *  返回指定区(section)包含的数据源条目数(number of items)，该方法必须实现
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
        return 1
    }
    
    /**
     *  返回某个indexPath对应的cell，该方法必须实现
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        var cell:UICollectionViewCell! = UICollectionViewCell.init()
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZYConstants.CellID, for: indexPath) as! HomeCollectionViewCell
        if let cell = cell as? HomeCollectionViewCell{
            cell.model = response?.data![indexPath.section]
            cell.delegate = self
        }
        return cell
    }
    
    /**
     *  为collection view添加一个补充视图(页眉或页脚)
     */
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath)
        
        return reusableView
    }
}

extension HomeViewController:HomeCollectionViewCellDelegate {
    
    func clickImageview(_ string: String?) {
        
        if let str = string {
            
            switch str {
            case "http://chewawa.cn/wawaowner_verify":
                
                let sb = UIStoryboard.init(name: "SimpleStoryboard", bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "AttertationViewController")
                navigationController?.pushViewController(vc, animated: true)
            default:
                print("default")
            }
        }
    }
}

