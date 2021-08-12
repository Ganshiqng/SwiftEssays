//
//  ScrollViewViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/7/22.
//

import UIKit
import JXSegmentedView

class ScrollViewViewController: BaseViewController ,JXSegmentedListContainerViewListDelegate{

    func listView() -> UIView {
        return view
    }
    
    
    lazy var scrollView : UIScrollView = {
       let view = UIScrollView()
        view.SQ_debug()
//        view.isDirectionalLockEnabled = true
//        view.showsHorizontalScrollIndicator = false
//        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true
        view.contentSize = CGSize(width: 3*SQ_kScreenWidth, height: view.SQ_extHeight())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let view  = UIView(frame: CGRect(x: SQ_kScreenWidth, y: 0, width: SQ_kScreenWidth, height: 100))
        view.backgroundColor = UIColor.red
        scrollView.addSubview(view)
//        view.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.left.equalToSuperview()
//            make.width.equalTo(SQ_kScreenWidth)
//        }
        
       
        // Do any additional setup after loading the view.
    }
    

   

}
