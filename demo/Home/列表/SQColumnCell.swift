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
        view.SQ_extSetCornerRadius(30)
    
        return view
    }()
    lazy var nameLabel : UILabel  = {
      let View = UILabel()
        
        View.SQ_extSetTextColor(UIColor.SQ_hex("7f7f7f"), font: Font_Reg_16)
        
        return View
    }()
    
    lazy var messageLabel : UILabel = {
        let view = UILabel()
        view.SQ_debug()
        view.SQ_extSetTextColor(UIColor.SQ_hex("333333"), font: Font_Reg_12)
        view.numberOfLines = 0
        view.SQ_SetLayerRadius(radius: 6)
      
        return view
    }()
    lazy var towMessageLabel : UILabel = {
       let view = UILabel()
        view.SQ_debug()
        view.SQ_extSetTextColor(UIColor.SQ_hex("333333"), font: Font_Reg_12)
        view.numberOfLines = 0
        view.SQ_SetLayerRadius(radius: 6)
        
        return view
    }()
    
    lazy var BottomImage : UIImageView = {
        let view = UIImageView()
        view.SQ_debug()
        return view
    }()
    
    //override 重写 //overload重载
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.SQ_addSubViews([header,nameLabel,messageLabel,towMessageLabel,BottomImage])
        self.SQ_setUpLayour()
    }
    
    
    /// Description这个叫必要初始化器，这种情况一般会出现在继承了遵守NSCoding protocol的类，比如UIView系列的类、UIViewController系列的类。
    
   // 为什么一定要添加：
    //这是NSCoding protocol定义的，遵守了NSCoding protoaol的所有类必须继承。只是有的情况会隐式继承，而有的情况下需要显示实现。
    /// - Parameter coder: coder description
    required init?(coder: NSCoder) {
        fatalError("")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //点击
    }
}

extension SQColumnCell {
    
    func SQ_setupModel(ui:(_ aheader:UIImageView, _ anameLabel:UILabel, _ amessageLabel:UILabel,_ towMessageLabel: UILabel,_ bottom:UIImageView) -> Void) {
        ui(header,nameLabel,messageLabel,towMessageLabel,BottomImage)
    }
    
    private func SQ_setUpLayour() {
    
        header.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(60)
        }
            
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(100)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        messageLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(100)
            make.top.equalTo(nameLabel.snp_bottom).offset(10)
            make.right.equalToSuperview() .offset(-10)
    //            make.height.equalTo(10)
        }
        towMessageLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(100)
            make.top.equalTo(messageLabel.snp_bottom).offset(10)
            make.right.equalToSuperview() .offset(-10)
        }
        BottomImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(100)
            make.top.equalTo(towMessageLabel.snp.bottom).offset(10)
        }

  }
}
