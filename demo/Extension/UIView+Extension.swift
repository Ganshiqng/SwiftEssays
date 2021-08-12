//
//  UIView+Extension.swift
//  demo
//
//  Created by 甘世清 on 2021/7/22.
//

import UIKit
import QMUIKit
import Motion
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
    
    
    /// layer切圆角 masksToBounds 为true
    /// - Parameter radius: 角度
    func SQ_SetLayerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
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
    
    
    /// 滑动视图截取长图
    /// - Parameters:
    ///   - scrollView: 滑动
    ///   - snapWidth: 截取宽度
    ///   - completion: 回调
    public func SQ_captureImage(_ scrollView: UIScrollView, snapWidth: CGFloat = UIScreen.main.bounds.size.width, completion: @escaping ((UIImage) -> Void)){
        let savedFrame = self.frame
        let savedSize = savedFrame.size
        let maxSize = scrollView.contentSize
        var newWidth = snapWidth
        if newWidth < maxSize.width {
            newWidth = maxSize.width
        }
        let newHeight = newWidth * maxSize.height / maxSize.width
        let totalBounds = CGRect(origin: CGPoint.zero, size: CGSize(width: newWidth, height: newHeight))
        guard maxSize.height > savedSize.height || maxSize.width > savedSize.width else {
            self.SQ_sanpShotArea(rect: totalBounds, completion: completion)
            return
        }
        
        if let temperView  = self.snapshotView(afterScreenUpdates: true) {
            let savedOffset = scrollView.contentOffset
            temperView.frame = CGRect(x: savedFrame.origin.x, y: savedFrame.origin.y, width: temperView.frame.size.width, height: temperView.frame.size.height)
            self.superview?.addSubview(temperView)
            if savedSize.height < maxSize.height {
                scrollView.contentOffset = CGPoint(x: 0, y: maxSize.height - savedSize.height)
            }
            scrollView.contentOffset = CGPoint.zero
            self.SQ_sanpShotArea(rect: totalBounds, completion: { (image) in
                completion(image)
                scrollView.contentOffset = savedOffset
                temperView.removeFromSuperview()
            })
        }
    }
    
    
    /// 截屏,
    /// - Parameters:
    ///   - rect: 尺寸
    ///   - completion: 回调
    public func SQ_sanpShotArea(rect: CGRect, completion: @escaping ((UIImage) -> Void)) {
        let scale = UIScreen.main.scale
        var newRect = rect
        var newSize = rect.size
        if scale == 0.0 {
            
        }else
        {
            newSize.width = newSize.width * scale
            newSize.height = newSize.height * scale
            newRect.size = newSize
        }
        let bakFrame = self.frame
        self.frame = rect
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        let t = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: t){
            for subview in self.subviews {
                subview.drawHierarchy(in: subview.bounds, afterScreenUpdates: true)
            }
            var capturedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if let ref = capturedImage?.cgImage?.cropping(to: newRect){
                capturedImage = UIImage.init(cgImage:  ref)
            }
            if capturedImage != nil{
                completion(capturedImage!)
            }
            self.frame = bakFrame
            
        }
    }
    
    
    /// 获取视图的屏幕截图，这个函数可以从你的应用程序的任何线程调用。
    /// - Returns: 屏幕截图的图像。
    func SQ_screenShot() -> UIImage? {
        guard frame.size.height > 0 && frame.size.width > 0 else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let  image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    /// 添加多个view到self.view上
    /// - Parameter views: 数组
    public func SQ_addSubViews(_ views : [UIView]){
        for view in views {
            self.addSubview(view)
        }
    }
    
    
    /// 将视图转换成图片
    /// - Parameter view: 视图
    /// - Returns: 返回图片
    func SQ_convertViewToImage(_ view : UIView) -> UIImage {
        UIGraphicsBeginImageContext(view.bounds.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }
    
    public func extBorderwithView(top : (Bool,CGFloat) = (false,0),
                                  bottom : (Bool,CGFloat) = (false,0),
                                  left :(Bool,CGFloat) = (false,0),
                                  right:(Bool,CGFloat) = (false,0),
                                  cgColor : CGColor = UIColor.clear.cgColor,
                                  borderWidth : CGFloat = 0){
      
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        UIColor.clear.setFill()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        path.fill()
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        
    }

}

extension UIView {
    public final func SQ_extUseAutoLayout(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    /// 设置渐变色
    /// - Parameters:
    ///   - startPoint: 起始位置
    ///   - endPoint: 终点
    ///   - colors: 颜色
    ///   - cornerRadius: 圆角
    public final func SQ_extGradientColor(startPoint : CGPoint = CGPoint (x: 0, y: 0),
                                          endPoint : CGPoint = CGPoint(x: 1, y: 1),
                                          colors : [UIColor],
                                          cornerRadius : CGFloat = 0){
        
        layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.frame = bounds
        let cgColors = colors.map({$0.cgColor})
        gradientLayer.colors = cgColors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, UIScreen.main.scale)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        backgroundColor = UIColor(patternImage: gradientImage!)
    }
    
    
    /// 获取视图的宽
    /// - Returns: 宽
    public final func SQ_extWidth() -> CGFloat {
        return self.frame.width
    }
    
    /// 获取视图的高
    /// - Returns: 高
    public final func SQ_extHeight() -> CGFloat {
        return self.frame.height
    }
    
    /// 获取视图 y坐标
    /// - Returns: y的miny
    public final func SQ_extTop () -> CGFloat {
        return self.frame.minY
    }
    
    
    /// 获取视图底的y值 miny+ 高度
    /// - Returns: 返回maxy
    public final func SQ_extBottom() -> CGFloat {
        return self.frame.maxY
    }
    
    
    /// 获取视图 x坐标
    /// - Returns: minx
    public final func SQ_extLeft() -> CGFloat {
        return self.frame.minX
    }
    
    
    /// 获取视图的右边y值 minx+宽度
    /// - Returns: maxx
    public final func SQ_extRight() -> CGFloat{
        return self.frame.maxX
    }
    
    
    /// 模态跳转
    /// - Parameters:
    ///   - vc: 跳转类
    ///   - backgroundeColor: 背景色
    ///   - animated: 是否动画
    public final func SQ_extShowModalVC(_ vc : UIViewController ,
                                        backgroundeColor :UIColor = UIColor.white ,
                                        animated : Bool = false){
        
        guard let appDelegate = UIApplication.shared.delegate else {
            return
        }
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
      
        appDelegate.window??.rootViewController!.present(vc, animated: animated, completion: {
            vc.view.backgroundColor = backgroundeColor
        })
        
    }
}


extension UIView {
    
    /// 设置视图圆角
    /// - Parameter radius: 角度
    public final func SQ_extSetCornerRadius(_ radius : CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    
    /// 设置部分圆角
    /// - Parameters:
    ///   - corners: 好像是枚举,可多传
    ///   - radius: 角度
    public final func SQ_extSetCornerRadius(corners : QMUICornerMask ,
                                            radius : CGFloat){
        layer.qmui_maskedCorners = corners
        layer.cornerRadius = radius
    }
    
    
    /// 设置边框
    /// - Parameters:
    ///   - width: 宽度
    ///   - color: 颜色
    public final func SQ_extSetBorderWidth(_ width: CGFloat,
                                           color : UIColor){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    class func SQ_viewVithShow() -> UIWindow {
        var window :UIWindow? = nil
        if #available(iOS 13.0, *) {
            for windowScenr:UIWindowScene in (UIApplication.shared.connectedScenes as? Set<UIWindowScene>)! {
                if windowScenr.activationState == .foregroundActive {
                    window = windowScenr.windows.last
                }
                break
            }
        }else {
            window = UIApplication.shared.keyWindow
        }
        return window!
    }
    
}


extension UIView {
    
    
    /// 圆角+阴影
    /// - Parameters:
    ///   - radius: radius description
    ///   - shadowColor: shadowColor description
    ///   - shadowOpacity: shadowOpacity description
    ///   - shadowOffset: shadowOffset description
    ///   - shadowRadius: shadowRadius description
    public final func SQ_extShadowCorner(radius: CGFloat,
                                         shadowColor: UIColor,
                                         shadowOpacity: Float,
                                         shadowOffset: CGSize,
                                         shadowRadius: CGFloat){
        animate(.delay(0),
                .duration(0),
                .corner(radius: radius),
                .depth(offset: shadowOffset, opacity: shadowOpacity, radius: shadowRadius),
                .shadow(color: shadowColor))
    }
    
    
    /// 影子角度
    /// - Parameter radius: radius description
    public final func SQ_extShadowCard(_ radius:CGFloat){
        SQ_extShadowCorner(radius: radius, shadowColor: UIColor.SQ_hex("#000000"), shadowOpacity: 0.03, shadowOffset: CGSize(width: 0, height: 1), shadowRadius: 6)
    }
    
    
    public final func SQ_extShadowButton(_ radius:CGFloat,
                                        color:UIColor = UIColor.SQ_hex("#FA6400", alpha: 0.14),
                                        opacity: Float = 1){
        SQ_extShadowCorner(radius: radius, shadowColor: color, shadowOpacity: opacity, shadowOffset: CGSize(width: 0, height: 7), shadowRadius: 6)
    }
    
    
    /// 渐变色
    /// - Parameters:
    ///   - colors: 颜色
    ///   - frame: 坐标
    ///   - cornerRadius: 角度
    func SQ_extGradientColor(colors:[UIColor],
                             frame: CGRect,
                             cornerRadius:CGFloat) {
        SQ_extGradientColor(startPoint: CGPoint.init(x: 0, y: 0), endPoint: CGPoint.init(x: 1, y: 1), colors: colors, cornerRadius: cornerRadius)
    }
    
    func SQ_extShowView() {
        if alpha == 1 && isHidden == false {
            return
        }
        alpha = 0
        isHidden = false
        animate(.delay(0),
                .duration(0.25),
                .fadeIn)
    }
    func SQ_extHiddenView()  {
        if alpha == 0 || isHidden == true {
          return
        }
        alpha = 1
        animate(.delay(0),
                .duration(0.25),
                .fadeOut,
                .completion {
                    [weak self] in self?.isHidden = true
                })
    }
    
}

 
