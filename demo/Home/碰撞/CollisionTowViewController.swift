//
//  CollisionTowViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/8/11.
//

import UIKit
import JXSegmentedView
class CollisionTowViewController: BaseViewController ,JXSegmentedListContainerViewListDelegate,UIDynamicAnimatorDelegate,UICollisionBehaviorDelegate{
    
    func listView() -> UIView {
        return view
    }
    lazy var oneView:UIView = {
        let view = UIView()
        view.SQ_debug()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.blue.cgColor
        return view
    }()
    
    lazy var minView:UIView = {
        let view = UIView()
        view.SQ_debug()
        view.layer.cornerRadius = 15
        return view
    }()

    var dynamicAnimator = UIDynamicAnimator()
    var snapBheavior:UISnapBehavior?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       SQ_UIView()
    }
    

    func SQ_UIView()  {
        dynamicAnimator.delegate = self
        
        view.SQ_addSubViews([oneView,minView])
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        minView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gravityBehavior = UIGravityBehavior.init(items: [minView])
        
       
        let pushBehavior = UIPushBehavior.init(items: [minView,oneView], mode: .instantaneous)
        pushBehavior.magnitude = 5
        
        let collision = UICollisionBehavior.init(items: [minView,oneView])
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(gravityBehavior)
        dynamicAnimator.addBehavior(pushBehavior)
        dynamicAnimator.addBehavior(collision)
    }
    //运动结束
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        SQ_Text("1111111111")
        print("333333")
//        dynamicAnimator.removeAllBehaviors()
    }
    //开始运动
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
        SQ_Text("动画开始")
        print("444444")
      
    }

}
