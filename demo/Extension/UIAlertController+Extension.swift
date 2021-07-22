//
//  UIAlertController+Extension.swift
//  demo
//
//  Created by 甘世清 on 2021/7/22.
//

import UIKit

extension UIAlertController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    open override var shouldAutorotate: Bool {
        return false
    }
}
