//
//  MapAnnotationViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/8/6.
//

import UIKit
import AMapNaviKit
import AMapLocationKit
class MapAnnotationViewController: BaseViewController, MAMapViewDelegate {

    var jsonArray =  NSMutableArray.init()
    
    lazy var mamapView: MAMapView = {
        let view = MAMapView()
        view.delegate = self
        view.showsUserLocation = true
        view.zoomLevel = 17
         view.userTrackingMode = .followWithHeading
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 
}
