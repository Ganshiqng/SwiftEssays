//
//  MapButtonView.swift
//  demo
//
//  Created by 甘世清 on 2021/8/3.
//

import UIKit
import SnapKitExtend
class MapButtonView: UIView {

    
    weak var delegate : MapButtonDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUI()  {
        let array = NSArray.init(objects: "医院","消防","交警","公安","街道办","安监")
        
        var arr : [UIView] = []

        
        for index in 0..<array.count {
            let button = UIButton()
            button.tag = index
            button.SQ_debug()
            button.addTarget(self, action: #selector(btn(_:)), for: .touchUpInside)
            button.setTitle(array[index] as? String, for: .normal)
            arr.append(button)
        }
        
        self.SQ_addSubViews(arr)
        arr.snp.distributeViewsAlong(axisType: .vertical, fixedSpacing: 0, leadSpacing: 0, tailSpacing: 0)
        arr.snp.makeConstraints{
            $0.width.equalTo(80)
        }
 
    }

    
    @objc  func btn(_ sender: Any) {
        if self.delegate != nil && ((self.delegate?.responds(to: Selector.init(("SQ_save:")))) != nil) {
            self.delegate?.SQ_save((sender as AnyObject).tag)
        }
    }

}

protocol  MapButtonDelegate : NSObjectProtocol{
    func SQ_save(_ index: NSInteger)
}
