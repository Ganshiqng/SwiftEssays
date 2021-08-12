//
//  SQHUD+Extension.swift
//  demo
//
//  Created by 甘世清 on 2021/8/9.
//

import UIKit
import SVProgressHUD
import MBProgressHUD
extension NSObject {
    
    
    func SQ_Toast(_ text:String) {
        dispatch_sync_safely_main_queue {
            SVProgressHUD.dismiss()
            SVProgressHUD.show(withStatus: text)
//            SVProgressHUD.dismiss(withDelay: 2)
        }
        
        
    }
    
    func SQ_ToastAlwaysShow(_ text:String)  {
        dispatch_sync_safely_main_queue {
            SVProgressHUD.dismiss()
            SVProgressHUD.show(UIImage(), status: text)
//            SVProgressHUD.show(withStatus: text) //转圈圈
//            SVProgressHUD.show() //单纯的转圈圈
//            SVProgressHUD.showProgress(1, status: text) //显示进度
//            SVProgressHUD.setImageViewSize(CGSize.init(width: 0, height: 0))
//            SVProgressHUD.showInfo(withStatus: text)
            SVProgressHUD.showSuccess(withStatus: text)
            SVProgressHUD.setDefaultStyle(.dark)
            
        }
    }
    
    func SQ_ToastDismiss() {
        SVProgressHUD.dismiss()
    }
    
}

extension NSObject {
    
    /// 菊花旋转提示
    /// - Parameter text: 文字
    func SQ_HUDText(_ text:String) {
        MBProgressHUD.SQ_ShowText(text)
    }
    
    /// 纯文字提示
    /// - Parameter text: 文字
    func SQ_Text(_ text:String)  {
        MBProgressHUD.SQ_Text(text)
    }
    
    func SQ_NoHideText(_ text:String)  {
        MBProgressHUD.SQ_NohideText(text)
    }
    
    /// 去除提示
    func SQ_HUDDismiss() {
        MBProgressHUD.SQ_hudDismiss()
        
    }
}



extension MBProgressHUD {
    
    fileprivate class func SQ_hudDismiss() {
        
        let view = SQ_viewVithShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.hide(animated: true)
        
    }
    
    /// 不带隐藏
    /// - Parameter text: 内容
    fileprivate class func SQ_NohideText(_ text:String){
      
        let view = SQ_viewVithShow()
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = text
        hud.animationType = .fade
        hud.mode = .indeterminate
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.style = .solidColor
        hud.bezelView.color = .black
        hud.contentColor = .white
    }
    
    fileprivate class func SQ_ShowText(_ text:String,_ delay:Double = 1){
        
        let view = SQ_viewVithShow()
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = text
//        hud.minSize = CGSize.init(width: 80, height: 80)
        hud.animationType = .fade
        hud.mode = .indeterminate
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.style = .solidColor
        hud.bezelView.color = .black
        hud.contentColor = .white
        hud.hide(animated: true, afterDelay: delay)
    }
    fileprivate class func SQ_Text(_ text:String,_ delay:Double = 1){
        
        let view = SQ_viewVithShow()
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = text
//        hud.minSize = CGSize.init(width: 80, height: 80)
        hud.animationType = .fade
        hud.mode = .text
        hud.removeFromSuperViewOnHide = true
//        hud.backgroundColor = .black
        hud.bezelView.color = .black
        hud.bezelView.style = .solidColor
        hud.contentColor = .white
        hud.margin = 10
        hud.hide(animated: true, afterDelay: delay)
    }
    
}
