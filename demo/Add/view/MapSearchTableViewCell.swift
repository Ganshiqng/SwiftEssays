//
//  MapSearchTableViewCell.swift
//  demo
//
//  Created by 甘世清 on 2021/8/6.
//

import UIKit

class MapSearchTableViewCell: UITableViewCell {

    
    lazy var name:UILabel = {
       let view = UILabel()
        view.SQ_extSetTextColor(.black, font: Font_Med_16)
        view.numberOfLines = 0
        return view
    }()
    lazy var distance:UILabel = {
       let view = UILabel()
        view.textAlignment = .center
        view.SQ_extSetTextColor(.red, font: Font_Med_14)
        return view
    }()
    lazy var address:UILabel = {
       let view = UILabel()
        view.numberOfLines = 0
        view.SQ_extSetTextColor(.gray, font: Font_Med_14)
        return view
    }()
    
    lazy var navigation:UILabel = {
       let view = UILabel()
       
        view.SQ_extSetText("点我规划导航", textColor: .blue, font: Font_Med_14)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.SQ_addSubViews([name,distance,address,navigation])
        self.SQ_layer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

extension MapSearchTableViewCell {
    
    func SQ_setupModel(ui:(_ name:UILabel,_ distance:UILabel,_ address:UILabel) -> Void) {
        ui(name,distance,address)
    }
    
    func SQ_layer()  {
        name.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(20)
                make.top.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-100)
//                make.height.equalTo(40)
            }
        distance.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(80)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        address.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(name.snp_bottom).offset(10)
            make.right.equalToSuperview().offset(-90)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-20)
        }
        navigation.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(90)
            make.top.equalTo(address)
            make.height.equalTo(40)
        }
        
    }
}
