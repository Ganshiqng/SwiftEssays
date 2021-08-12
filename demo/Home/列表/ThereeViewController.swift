//
//  ThereeViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/7/16.
//

import UIKit
import JXSegmentedView
 
class ThereeViewController: BaseViewController ,JXSegmentedListContainerViewListDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var tableView = UITableView()
    
    func listView() -> UIView {
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        // Do any additional setup after loading the view.
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.SQ_extRegistCell([SQColumnCell.self], ["SQColumnCell"])
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
      
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "SQColumnCell") as! SQColumnCell
        self.SQ_setcell(cell)
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}


extension ThereeViewController {
    func SQ_setcell(_ cell : SQColumnCell)  {
        
        cell.SQ_setupModel { (aimage , nameLabel, messageLabel,towMessageLabel,bottomImage) in
            let url = URL(string:"https://s3.ax1x.com/2021/02/06/yYW3Ie.png")!

            aimage.kf.setImage(with: url)
            nameLabel.text = "名字名字名字"
            let index:Int = Int(arc4random()%200)
            
            messageLabel.text = String.SQ_randomStr(len: index)
            let index2:Int = Int(arc4random()%200)
            towMessageLabel.text = String.SQ_randomStr(len: index2)
            bottomImage.snp.updateConstraints { make in
                make.height.equalTo(index2)
            }
        }
    }
}
