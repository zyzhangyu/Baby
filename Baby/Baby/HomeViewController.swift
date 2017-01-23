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
    
    var zyCollectionView:UICollectionView!
    fileprivate let HeadViewHeight:CGFloat = 200.0
    var response:HomeResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout.init()
        zyCollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        zyCollectionView.backgroundColor = UIColor.cyan
        zyCollectionView.delegate = self
        zyCollectionView.dataSource = self
        zyCollectionView.register(HotRecommendCollectionViewCell.self, forCellWithReuseIdentifier: ZYConstants.CellHot)
        zyCollectionView.register(InsuranceCollectionViewCell.self, forCellWithReuseIdentifier: ZYConstants.CellInsurance)
        zyCollectionView.register(AppreciationCollectionViewCell.self, forCellWithReuseIdentifier: ZYConstants.CellAppreciation)
        zyCollectionView.register(GasolineCollectionViewCell.self, forCellWithReuseIdentifier: ZYConstants.CellGasoline)
        zyCollectionView.register(InsureCollectionViewCell.self, forCellWithReuseIdentifier: ZYConstants.CellInsure)
        zyCollectionView.register(MoreCollectionViewCell.self, forCellWithReuseIdentifier: ZYConstants.CellMore)
        zyCollectionView.register(HomeBannerViewCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        zyCollectionView.register(MoreCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MoreHeader")
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
            return CGSize.init(width: ZYConstants.SCREENWIDTH, height: HeadViewHeight)
        } else if section == 5 {
            return CGSize.init(width: ZYConstants.SCREENWIDTH, height: 50)
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
        
        
        
        if indexPath.section == 0 {
            
            return CGSize.init(width: ZYConstants.SCREENWIDTH, height: 200)
        } else if indexPath.section == 1 {
            return CGSize.init(width: ZYConstants.SCREENWIDTH, height: 300)
        } else if indexPath.section == 2 {
            return CGSize.init(width: ZYConstants.SCREENWIDTH, height: 150)
        } else if indexPath.section == 3 {
            return CGSize.init(width: ZYConstants.SCREENWIDTH, height: 250)
        }  else if indexPath.section == 4 {
            return CGSize.init(width: ZYConstants.SCREENWIDTH, height: 250)
        } else if indexPath.section == 5 {
            return CGSize.init(width: 60, height: 60)
        }
        return CGSize.zero
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
        
        
        if section == 0 {
            return 1;
        } else if section == 1 {
            return 1;
        } else if section == 2 {
            return 1;
        } else if section == 3 {
            return 1;
        } else if section == 4 {
            return 1;
        } else if section == 5 {
            return 8;
        }
        
        return 0
    }
    
    /**
     *  返回某个indexPath对应的cell，该方法必须实现
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        var cell:UICollectionViewCell! = UICollectionViewCell.init()
        
        if indexPath.section == 0 {
            let topItems:Array<HomeItemModel> = (response?.data![indexPath.section].rows![0])!;
            let bottomItem:Array<HomeItemModel> = (response?.data![indexPath.section].rows![1])!;

            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZYConstants.CellHot, for: indexPath) as! HotRecommendCollectionViewCell
            if let cell = cell as? HotRecommendCollectionViewCell{
                cell.topImageView.sd_setImage(with: URL.init(string: topItems[0].BlockBackgroupImgUrl!))
                cell.leftImageView.sd_setImage(with: URL.init(string: bottomItem[0].BlockBackgroupImgUrl!))
                cell.rightImageView.sd_setImage(with: URL.init(string: bottomItem[1].BlockBackgroupImgUrl!))
            }
            
        } else if indexPath.section == 1 {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZYConstants.CellInsurance, for: indexPath) as! InsuranceCollectionViewCell
        } else if indexPath.section == 2 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZYConstants.CellAppreciation, for: indexPath) as! AppreciationCollectionViewCell
        } else if indexPath.section == 3 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZYConstants.CellGasoline, for: indexPath) as! GasolineCollectionViewCell
        } else if indexPath.section == 4 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZYConstants.CellInsure, for: indexPath) as! InsureCollectionViewCell
        } else if indexPath.section == 5 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZYConstants.CellMore, for: indexPath) as! MoreCollectionViewCell
            if let cell = cell as? MoreCollectionViewCell{
                cell.icon = #imageLiteral(resourceName: "icon40")
                cell.content = "abcd"
            }
        }


        return cell
    }
    
    /**
     *  为collection view添加一个补充视图(页眉或页脚)
     */
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath)
        
        if indexPath.section == 5 {
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MoreHeader", for: indexPath)
        }
        return reusableView
    }
}


