//
//  ImageTopView.swift
//  demo
//
//  Created by 甘世清 on 2021/7/13.
//

import UIKit

class ImageTopView: UIView {

    var imageViews = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init (frame : CGRect){
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        self.alpha = 0.5
        self.isUserInteractionEnabled = true
        imageViews = UIImageView()
        imageViews.contentMode = .scaleAspectFill
        self.addSubview(imageViews)
        imageViews.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let fullPath = NSHomeDirectory().appending("/Documents/").appending("home")
       
     
        if let savedImage = UIImage(contentsOfFile: fullPath) {
            imageViews.image = savedImage
         } else {
             print("文件不存在")
         }
    }
    convenience init() {
        self.init(frame:CGRect.zero)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }

}
