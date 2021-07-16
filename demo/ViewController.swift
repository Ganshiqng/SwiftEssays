//
//  ViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/6/18.
//
 
import UIKit
import SnapKit
class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabBar.isTranslucent = false
        addNormalTabbar()
    }
    
    func addNormalTabbar() {
          
          setupOneChildViewController(title: "首页", image: "tabBar_essence_icon", seletedImage: "tabBar_essence_click_icon", controller: HomeViewController.init())
          setupOneChildViewController(title: "发现", image: "tabBar_friendTrends_icon", seletedImage: "tabBar_friendTrends_click_icon", controller: AddViewController.init())
          setupOneChildViewController(title: "我的", image: "tabBar_me_icon", seletedImage: "tabBar_me_click_icon", controller: MeViewController.init())
  
      }
      fileprivate func  setupOneChildViewController(title: String,image: String,seletedImage: String,controller: UIViewController){
          controller.tabBarItem.title = title
          //这里设置背景色 是每一个vc设置的都一样
          controller.view.backgroundColor = UIColor.white
          controller.tabBarItem.image = UIImage.init(named: image)
          controller.tabBarItem.selectedImage = UIImage.init(named: seletedImage)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
          let naviController = UINavigationController.init(rootViewController: controller)
          addChild(naviController)
      }
}

