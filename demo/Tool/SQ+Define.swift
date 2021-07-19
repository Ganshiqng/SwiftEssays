//
//  SQ+Define.swift
//  demo
//
//  Created by 甘世清 on 2021/7/16.
//

import UIKit
import DeviceKit


func HLFont(_ fontSize: CGFloat) -> UIFont {
    return HLFont(ofSize: fontSize);
}

func HLFont(ofSize: CGFloat, weight :UIFont.Weight = .regular) -> UIFont {
    
    var familyName = ""
    switch weight {
    case .regular:
        familyName = "PingFangSC-Regular"
    case .medium:
        familyName = "PingFangSC-Medium"
    case .semibold:
        familyName = "PingFangSC-Semibold"
    default:
        familyName = "PingFangTC-Regular"
    }
    
    let size = ofSize * (kScreenWidth / 375.0)
    
    if let font = UIFont.init(name: familyName, size: size) {
        return font
    } else {
        return HLFont(ofSize: size, weight: weight);
    }
}



