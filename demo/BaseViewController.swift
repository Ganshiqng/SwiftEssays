//
//  BaseViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/7/21.
//

import UIKit
import SDWebImage
import Kingfisher
import JXSegmentedView

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
   
    func SQ_pushvc(_ vc:UIViewController,_ animated : Bool = false) {
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
