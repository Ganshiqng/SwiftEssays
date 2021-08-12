//
//  MapListTableViewCell.swift
//  demo
//
//  Created by 甘世清 on 2021/8/2.
//

import UIKit

class MapListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    lazy var titleLabel:UILabel = {
        let view = UILabel()
        view.SQ_extSetText("", textColor: UIColor.black, font: Font_Med_12)
        view.numberOfLines = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.SQ_addSubViews([titleLabel])
        self.SQ_layer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
}

extension MapListTableViewCell {
    
    
    func SQ_setupModel(ui:(_ titlelabel:UILabel) -> Void) {
        ui(titleLabel)
    }
    
    private func SQ_layer() {
        
        titleLabel .snp.makeConstraints { make  in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
}
