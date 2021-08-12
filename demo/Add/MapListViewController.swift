//
//  MapListViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/8/2.
//

import UIKit
import AMapLocationKit
import AMapSearchKit
class MapListViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
   
    var jsonArray =  NSMutableArray.init()
    
    lazy var tableview:UITableView = {
       let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    
    typealias SQ_poiBlock = (_ poi:AMapPOI) -> Void
    
    var SQ_block : SQ_poiBlock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "搜索结果"
        // Do any additional setup after loading the view.
        view.addSubview(tableview)
        tableview.SQ_extRegistCell([MapListTableViewCell.self], ["MapListTableViewCell"])
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapListTableViewCell") as! MapListTableViewCell
        self.SQ_cell(cell,indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mamp:AMapPOI = jsonArray[indexPath.row] as! AMapPOI
        //回调
        self.SQ_block?(mamp)
        self.navigationController?.popViewController(animated: true)
    }
   

}

extension MapListViewController {
    
    func SQ_cell(_ cell: MapListTableViewCell ,_ index : IndexPath)  {
        cell.SQ_setupModel { title in
            let mamp:AMapPOI = jsonArray[index.row] as! AMapPOI
            title.text = mamp.address + "_" + mamp.name
        }
    }
}
