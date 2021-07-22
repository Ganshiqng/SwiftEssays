//
//  BaseViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/7/21.
//

import UIKit
import SDWebImage
import Kingfisher
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    

    

}
