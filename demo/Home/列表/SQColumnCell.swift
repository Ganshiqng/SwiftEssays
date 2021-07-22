//
//  SQColumnItem.swift
//  demo
//
//  Created by 甘世清 on 2021/7/22.
//

import UIKit
class SQColumnCell: UITableViewCell {
    
    lazy var header : UIImageView = {
        let view = UIImageView()
        view.SQ_debug()
        view.SQ_SetTopBorderRoundingCorners(corner: 4)
    
        return view
    }()
}
