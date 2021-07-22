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
        cell?.imageView?.kf.setImage(with: URL(string: "https://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=美女&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&hd=undefined&latest=undefined&copyright=undefined&cs=1545655807,459773094&os=3475484516,1732021831&simid=3481281205,272653339&pn=188&rn=1&di=79310&ln=2000&fr=&fmq=1626862544348_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&is=0,0&istype=0&ist=&jit=&bdtype=0&spn=0&pi=0&gsm=96&objurl=https%3A%2F%2Fgimg2.baidu.com%2Fimage_search%2Fsrc%3Dhttp%253A%252F%252Fpic1.win4000.com%252Fwallpaper%252F2020-07-20%252F5f1554f6d025b.jpg%26refer%3Dhttp%253A%252F%252Fpic1.win4000.com%26app%3D2002%26size%3Df9999%2C10000%26q%3Da80%26n%3D0%26g%3D0n%26fmt%3Djpeg%3Fsec%3D1629454553%26t%3D55f04501ae9cc37f085454b1eb44dbdb&rpstart=0&rpnum=0&adpicid=0&nojc=undefined"))
      
      return cell!
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
