//
//  UIButton+Extension.swift
//  demo
//
//  Created by 甘世清 on 2021/7/20.
//

import UIKit
import Foundation


/**
 UIButton图像文字同时存在时---图像相对于文字的位置
 
 - top:    图像在上
 - left:   图像在左
 - right:  图像在右
 - bottom: 图像在下
 */
enum SQButtonImageEdgeInsetsStyle {
    case top,left , right , bottom
}

enum SQButtonImagePosition {
    case top //图片在上，文字在下，垂直居中对齐
    case bottom       //图片在下，文字在上，垂直居中对齐
    case left         //图片在左，文字在右，水平居中对齐
    case right        //图片在右，文字在左，水平居中对齐
}

extension UIButton {
    func imagePosition(at style:SQButtonImageEdgeInsetsStyle, space: CGFloat){
        guard let imageV = imageView  else {return}
        guard let titleL = titleLabel else {return}
        //获取图像的宽高
        let imageWidth = imageV.frame.size.width
        let imageHeight = imageV.frame.size.height
        //获取文字的宽高
        let labelWidth = titleL.intrinsicContentSize.width
        let labelHeight = titleL.intrinsicContentSize.height
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: -labelWidth - space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -imageHeight * 0.5 - space * 0.5, left: labelWidth * 0.5, bottom: imageHeight * 0.5 + space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: labelHeight * 0.5 + space * 0.5, left: -imageWidth * 0.5, bottom: -labelHeight * 0.5 - space * 0.5, right: imageWidth * 0.5)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + space * 0.5, left: labelWidth * 0.5, bottom: -imageHeight * 0.5 - space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: -labelHeight * 0.5 - space * 0.5, left: -imageWidth * 0.5, bottom: labelHeight * 0.5 + space * 0.5, right: imageWidth * 0.5)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
    
    
    func iamgePosition(style: SQButtonImagePosition, spacing:CGFloat) {
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat!  = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - spacing/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageWidth!-spacing/2, right: 0)
            break;
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            break;
        
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: -labelWidth!-spacing/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-spacing/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -labelWidth-spacing/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-spacing/2, bottom: 0, right: imageWidth!+spacing/2)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
}

class SQButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit()  {
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = 2;
        self.titleLabel?.minimumScaleFactor = 8.0
        self.imageView?.contentMode = .scaleAspectFit
        self.titleLabel?.font = HLFont(ofSize: 15)
    }
    
    
    
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleX = 0
        let titleY = contentRect.size.height * 0.35
        let titleW = contentRect.size.width
        let titleH = contentRect.size.height - titleY
        
        return CGRect(x: CGFloat(titleX), y: titleY, width: titleW, height: titleH)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW = contentRect.width
        let imageH = contentRect.size.height * 0.4
        return CGRect(x: 0, y: 5, width: imageW, height: imageH)
        
    }
}
typealias ActionBlock = ((UIButton)->Void)

extension UIButton {
    public final func extSetTitle(_ title : String,
                                  _ titleFont : UIFont,
                                  _ titleColor : UIColor,
                                  _ state : UIControl.State) {
        self.setTitle(title, for: state)
        self.titleLabel?.font = titleFont
        self.setTitleColor(titleColor, for: state)
    }
    
    private struct Associatedkeys {
        static var ActionBlock = "ActionBlock"
        static var ActionDelay = "ActionDelay"
    }
    
    private var actionBlock:ActionBlock? {
        set {
            objc_setAssociatedObject(self, &Associatedkeys.ActionBlock, newValue,.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, &Associatedkeys.ActionBlock) as? ActionBlock
        }
    }
    
    private var actionDelay: TimeInterval {
        set {
            objc_setAssociatedObject(self, &Associatedkeys.ActionDelay, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &Associatedkeys.ActionDelay) as? TimeInterval ?? 0
        }
    }
    
    @objc private func btnDelayClick(_ button: UIButton){
        UIView.animate(withDuration: 0.3) {
            button.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3) {
                button.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
                UIView.animate(withDuration: 0.3) {
                    button.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                }
            }
        }
        actionBlock?(button)
        isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + actionDelay){
            [weak self] in
            self?.isEnabled = true
        }
    }
    
    func addAction(_ delay: TimeInterval = 0, action:@escaping ActionBlock)  {
       
        addTarget(self, action: #selector(btnDelayClick(_:)), for: .touchUpInside)
        actionDelay = delay
        actionBlock = action
    }
    
    
}

 
