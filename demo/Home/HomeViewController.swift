//
//  HomeViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/6/18.
//

import UIKit
import JXSegmentedView
import SwiftyUserDefaults




class HomeViewController: BaseViewController, JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {
   
    
  
    var segmentedView = JXSegmentedView()
    var segmentedDataSource : JXSegmentedDotDataSource!
    var listContainerView: JXSegmentedListContainerView!
    var VCArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    
        VCArray = NSMutableArray.init()
        VCArray.add(oneViewController.init())
        VCArray.add(towViewController.init())
        VCArray.add(ThereeViewController.init())
        VCArray.add(ScrollViewViewController.init())
        VCArray.add(CyclescrollViewController.init())
        VCArray.add(CollisionViewController.init())
        VCArray.add(CollisionTowViewController.init())
        
        // Do any additional setup after loading the view.
        self.segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 60, width: SQ_kScreenWidth, height: 44))
        self.segmentedView.delegate = self;
        
        self.segmentedDataSource = JXSegmentedDotDataSource()
        self.segmentedDataSource.titleNormalColor = UIColor(red: 127 / 255, green: 127 / 255, blue: 127 / 255, alpha: 1)
        self.segmentedDataSource.titleSelectedColor = UIColor.blue
        self.segmentedDataSource.titleSelectedFont = UIFont.init(name: "PingFangSC-Medium", size: 18)
        self.segmentedDataSource.titleNormalFont =  UIFont.systemFont(ofSize: 18)
        self.segmentedDataSource.titleSelectedZoomScale = 1.33
//        self.segmentedDataSource.itemWidth = 38
        self.segmentedDataSource.itemWidthIncrement = SQ_kScreenWidth <= 375 ? 0 : 13
        self.segmentedDataSource.itemSpacing = 24
        self.segmentedDataSource.isTitleZoomEnabled = true
        self.segmentedDataSource.isTitleColorGradientEnabled = true
        self.segmentedDataSource.isTitleStrokeWidthEnabled = true
        self.segmentedDataSource.isSelectedAnimable = true
        self.segmentedDataSource.isItemSpacingAverageEnabled = false
       
        self.segmentedDataSource.dotSize = CGSize(width: 5, height: 5)
        self.segmentedDataSource.dotOffset = CGPoint(x: 4, y: 6)
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 30
        indicator.indicatorHeight = 8
        indicator.verticalOffset = 10
        indicator.indicatorCornerRadius = 2
        indicator.indicatorColor = UIColor(red: 14 / 255, green: 169 / 255, blue: 176 / 255, alpha: 1)
        self.segmentedView.indicators = [indicator]
        self.segmentedDataSource.titles = ["摄影","相册","列表","ScrollView","轮播图","碰撞","碰撞动画"]
        let arr = NSMutableArray()
        
        for _ in self.segmentedDataSource.titles {
            arr.add(false)
        }
        self.segmentedDataSource.dotStates = arr as! [Bool]
        segmentedView.collectionView.isDirectionalLockEnabled = true
        segmentedView.dataSource = segmentedDataSource
        segmentedView.defaultSelectedIndex = 6
        view.addSubview(self.segmentedView)
        
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        view.addSubview(listContainerView)
        segmentedView.listContainer = listContainerView
        
        
    }
    
    override func viewDidLayoutSubviews() {
        listContainerView.snp.makeConstraints { (make) in
            make.width.equalTo(SQ_kScreenWidth)
            make.top.equalTo(segmentedView.snp.bottom)
            make.left.bottom.equalToSuperview()
        }
    }
    
    
    //选中
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return VCArray.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return VCArray.object(at: index) as! JXSegmentedListContainerViewListDelegate
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
