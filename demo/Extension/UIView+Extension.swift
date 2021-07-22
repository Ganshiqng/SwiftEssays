//
//  UIView+Extension.swift
//  demo
//
//  Created by 甘世清 on 2021/7/22.
//

import UIKit

extension UIView {
    
    /// 任意随机背景色
   func SQ_debug()  {
        backgroundColor = UIColor.SQ_randomColor
    }
  
    /// 删除所有约束
    func SQ_removeAllAutoLayout()  {
        self.removeConstraints(self.constraints)
    }
    
    
    
    /// 删除所有子视图
    func SQ_removeAllSubViews()  {
        for item in self.subviews {
            item.removeFromSuperview()
        }
    }
    
    
    /// 设置uiview的顶部左右圆角
    /// - Parameter corner: 角度
    func SQ_SetTopBorderRoundingCorners(corner: CGFloat) {
        
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight], cornerRadii: CGSize(width: corner, height: corner))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    /// 设置view的底部左右圆角
    /// - Parameter corner: 角度
    func SQ_setBottomBorderRoundingCorners(corner: CGFloat) {
        let maskPath =  UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [UIRectCorner.bottomLeft,UIRectCorner.bottomRight], cornerRadii: CGSize(width: corner, height: corner))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    /// 封装的layer方法
    /// - Parameters:
    ///   - radius: 角度
    ///   - roundingCorners: roundingCorners description
    func SQ_setCornersRadius(radius: CGFloat, roundingCorners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        maskLayer.shouldRasterize = true
        maskLayer.rasterizationScale = UIScreen.main.scale
        layer.mask = maskLayer
        
    }
    
    /// 全切圆角
    /// - Parameter radius: radius description
    func SQ_SetCornerSRadius(radius: CGFloat) {
        self.SQ_setCornersRadius(radius: radius, roundingCorners: [.topLeft,.topRight,.bottomRight,.bottomLeft])
    }
}

extension UISearchBar {
    
    func SQ_setSearchBarBackgroundColor(to color:UIColor) {
        if let subView = self.subviews.first {
            if let view = subView.subviews.first,let imageView = view as? UIImageView{
                imageView.alpha = 0.0
                self.backgroundColor = color
            }
        }
    }
    
}

extension UIView {
    
    public func SQ_captureImage(_ scrollView: UIScrollView, snapWidth: CGFloat = UIScreen.main.bounds.size.width, completion: @escaping ((UIImage) -> Void)){
        let savedFrame = self.frame
        
        
    }
}

 
