//
//  ThereeViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/7/16.
//

import UIKit
import JXSegmentedView
 
class ThereeViewController: RootViewController ,JXSegmentedListContainerViewListDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var tableView = UITableView()
    
    func listView() -> UIView {
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.SQ_randomColor
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "testCellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = "标题标题"
        cell?.detailTextLabel?.text = "内容标题"
        let fullPath = NSHomeDirectory().appending("/Documents/").appending("home")
        if let savedImage = UIImage(contentsOfFile: fullPath) {
            
            cell?.imageView?.image = savedImage
         } else {
             print("文件不存在")
         }
      return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

   

}
