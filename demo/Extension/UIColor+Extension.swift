//
//  UIColor+Extension.swift
//  demo
//
//  Created by 甘世清 on 2021/7/19.
//

import UIKit

extension UIColor {
    
    //随机颜色
    public class var SQ_randomColor:UIColor{
        get
        {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
    }
    
    convenience init(valueRGB: UInt,alpha:CGFloat = 1.0) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    public final class func SQ_extRGBA(red: CGFloat ,
                                  green: CGFloat,
                                  blue: CGFloat,
                                  alpha: CGFloat)-> UIColor{
               return UIColor.init(red: red/255.0,
                                  green: green/255.0,
                                  blue: blue/255.0,
                                  alpha: alpha)
    }
    
    public final class func SQ_hex(_ hex :String,
                                alpha:CGFloat = 1) -> UIColor {
        var hexColor = hex
        hexColor = hexColor.replacingOccurrences(of: " ", with: " ")
        if hexColor.hasPrefix("#") {
            hexColor = String(hexColor.suffix(from: hexColor.index(hexColor.startIndex, offsetBy: 1)))
        }
        
        let redStr = String(hexColor[hexColor.startIndex ..< hexColor.index(hexColor.startIndex, offsetBy: 2)])
        
        let greenStr = String(hexColor[hexColor.index(hexColor.startIndex, offsetBy: 2) ..< hexColor.index(hexColor.startIndex, offsetBy: 4)])
        
        let blueStr = String(hexColor[hexColor.index(hexColor.startIndex, offsetBy: 4) ..< hexColor.index(hexColor.startIndex, offsetBy: 6)])
        
        var r = UInt64()
        var g = UInt64()
        var b = UInt64()
        
        Scanner.init(string: redStr).scanHexInt64(&r)
        Scanner.init(string: greenStr).scanHexInt64(&g)
        Scanner.init(string: blueStr).scanHexInt64(&b)
        let color : UIColor = UIColor.init(red: CGFloat(r)/255.0,
                                         green: CGFloat(g)/255.0,
                                         blue: CGFloat(b)/255.0,
                                         alpha: alpha)
        return color
    }
    
    func overlayWhite() -> UIColor {
        return self.add(overlay: UIColor.white.withAlphaComponent(0.15))
    }
    func add(overlay: UIColor) -> UIColor {
        var bgR:CGFloat = 0
        var bgG:CGFloat = 0
        var bgB:CGFloat = 0
        var bgA:CGFloat = 0
        
        
        var fgR:CGFloat = 0
        var fgG:CGFloat = 0
        var fgB:CGFloat = 0
        var fgA:CGFloat = 0
        
        self.getRed(&bgR, green: &bgG, blue: &bgB, alpha: &bgA)
        overlay.getRed(&fgR, green: &fgG, blue: &fgB, alpha: &fgA)
        let r = fgA * fgR + (1 - fgA) * bgR
        let g = fgA * fgR + (1 - fgA) * bgG
        let b = fgA * fgR + (1 - fgA) * bgB
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)

    }
    
    
}
