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


//color
let MTBackgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
let MTGrayDividingLineColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
let MTStatusBarBackgroundColor = UIColor(red: 1.0, green: 222/255, blue: 223/255, alpha: 1)
let MTTextColorBlack = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
let MTTextColorGray = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
let MTTextColorLightGray = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
let MTTextColorLittleLightGray = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
let MTextColorSampleLightGrayColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)

let MTTintColorGreen = UIColor(red: 0.05, green: 0.66, blue: 0.69, alpha: 1)
let MTTintColorDarkGreen = UIColor(red: 0.04, green: 0.53, blue: 0.55, alpha: 1)
let MTTintColorTextGreen = UIColor(red: 0.13, green: 0.69, blue: 0.85, alpha: 1)
let MTTintColorLightGray = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
let MTTintColorLightGreen = UIColor(red: 0.13, green: 0.69, blue: 0.85,alpha:1)
let MTTintColorRed = UIColor(red: 1, green: 0.31, blue: 0.31, alpha: 1)
let MTTintColorPink = UIColor(red: 1, green: 0.35, blue: 0.37, alpha: 1)
let MTTintColorLightPink = UIColor(red: 1, green: 0.24, blue: 0.24, alpha: 1)
let MTTintColorYellow = UIColor(red: 1, green: 0.7, blue: 0.07, alpha: 1)
let MTTintColorDarkRed = UIColor(red: 0.84, green: 0.29, blue: 0.23, alpha: 1)

//UIColor(displayP3Red: 250/255.0,green:250/255.0,blue:250/255.0,alpha:1.0)

let NavigationBarColor = UIColor(displayP3Red: 27/255.0,green:108/255.0,blue:230/255.0,alpha:1.0)



