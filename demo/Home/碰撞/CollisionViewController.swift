//
//  CollisionViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/8/10.
//

import UIKit
import JXSegmentedView

class CollisionViewController: BaseViewController ,JXSegmentedListContainerViewListDelegate,UICollisionBehaviorDelegate{
    
    func listView() -> UIView {
        return view
    }
    
    lazy var oneView:UIView = {
        let view = UIView()
        view.SQ_debug()
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.yellow.cgColor
        return view
    }()
    
    lazy var towView:UIView = {
        let view = UIView()
        view.SQ_debug()
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.green.cgColor
        return view
    }()
    
    lazy var threeView:UIView = {
        let view = UIView()
        view.SQ_debug()
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.blue.cgColor
        return view
    }()
    
    var dynamicAnimator = UIDynamicAnimator()
    var snapBheavior:UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "碰撞"
        // Do any additional setup after loading the view.
        SQ_uiView()
    }
    
    func SQ_uiView()  {
      
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        view.addSubview(oneView)
        view.addSubview(towView)
        view.addSubview(threeView)
        oneView.frame = CGRect.init(x: 145, y: 20, width: 50, height: 50)
        towView.frame = CGRect.init(x: 120, y: 300, width: 100, height: 100)
        threeView.frame = CGRect.init(x: 200, y: 100, width: 17, height: 17)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //重力行为
        let gravite = UIGravityBehavior(items: [threeView])
        gravite.magnitude = 5
        //碰撞行为
        let collisionBehavior = UICollisionBehavior(items: [oneView,towView,threeView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        
//        //图1的弹性,摩擦力,密度,阻尼
//        let litterBehavior = UIDynamicItemBehavior(items: [oneView])
//        //弹性
//        litterBehavior.elasticity = 1.0
//        //密度
//        litterBehavior.density = 2.2
//
//        //图2的
//        let hugeBehavior = UIDynamicItemBehavior(items:[towView])
//        hugeBehavior.elasticity = 0.8
//        hugeBehavior.resistance = 0.3
//        hugeBehavior.density = 10.2
        
        dynamicAnimator.addBehavior(gravite)
        dynamicAnimator.addBehavior(collisionBehavior)
//        dynamicAnimator.addBehavior(litterBehavior)
//        dynamicAnimator.addBehavior(hugeBehavior)
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: view)
        if snapBheavior != nil {
            dynamicAnimator.removeBehavior(snapBheavior!)
        }
        
        snapBheavior = UISnapBehavior(item: threeView, snapTo: point!)
        snapBheavior?.damping = 0.2
        dynamicAnimator.addBehavior(snapBheavior!)
        
    }
    
    //结束碰撞
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        let color = threeView.backgroundColor
        threeView.backgroundColor = oneView.backgroundColor
        oneView.backgroundColor = towView.backgroundColor
        towView.backgroundColor = color
        
    }
    //开始碰撞
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        
    }
 

}
