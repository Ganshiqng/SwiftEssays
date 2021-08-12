//
//  String+Extension.swift
//  demo
//
//  Created by 甘世清 on 2021/7/23.
//

import UIKit


extension String {
    static let random_str_characters = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static func SQ_randomStr(len : Int) -> String {
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index) ])
        }
        return ranStr
    }
}

