//
//  MapSearchViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/8/6.
//

import UIKit
import AMapLocationKit
import AMapSearchKit
import AMapNaviKit
class MapSearchViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
   
    var dinate = CLLocationCoordinate2D()
    

    var jsonArray =  NSMutableArray.init()
    
    lazy var tableview:UITableView = {
       let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableview)
        tableview.SQ_extRegistCell([MapSearchTableViewCell.self], ["MapSearchTableViewCell"])
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let btn = UIBarButtonItem.init(title: "查看地图", style: .plain, target: self, action: #selector(SQ_lookMap))
        self.navigationItem.rightBarButtonItem = btn
        
        
    }
    @objc func SQ_lookMap() {
        let vc = MapAnnotationViewController.init()
        vc.jsonArray = jsonArray
        self.SQ_pushvc(vc, true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapSearchTableViewCell") as! MapSearchTableViewCell
        self.SQ_cell(cell, indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mamp:AMapPOI = jsonArray[indexPath.row] as! AMapPOI
        
    }

}

extension MapSearchViewController
{
    func SQ_cell(_ cell: MapSearchTableViewCell ,_ index : IndexPath)  {
         
        cell.SQ_setupModel { name, distance, address in
            let mamp:AMapPOI = jsonArray[index.row] as! AMapPOI
            name.text = mamp.name
            distance .text = String(mamp.distance)+"m"
            address.text = mamp.address
        }
    }
}
