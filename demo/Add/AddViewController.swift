//
//  AddViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/6/18.
//

import UIKit
import AMapNaviKit
import AMapSearchKit
import AMapLocationKit

class AddViewController: BaseViewController,MAMapViewDelegate ,AMapSearchDelegate,MapButtonDelegate{

    lazy var mamapView: MAMapView = {
        let view = MAMapView()
        view.delegate = self
        view.showsUserLocation = true
        view.zoomLevel = 17
         view.userTrackingMode = .followWithHeading
        return view
    }()
  
    lazy var textfield:UITextField = {
        let view = UITextField()
        view.placeholder = "搜索地址"
        view.backgroundColor = .lightGray
        view.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.leftViewMode = .always
        return view
    }()
    
    lazy var rightButton:UIButton = {
        let view = UIButton()
        view.SQ_debug()
        view.setTitle("搜索", for: .normal)
        view.titleLabel?.font = Font_Med_14
        view.addTarget(self, action: #selector(SQ_Search), for: .touchUpInside)
        return view
    }()
    
    
    lazy var search:AMapSearchAPI? = {
        let view = AMapSearchAPI()
        view?.delegate = self
        return view
    }()
    lazy var request:AMapPOIKeywordsSearchRequest = {
       let view = AMapPOIKeywordsSearchRequest()
        view.requireExtension = true
        view.cityLimit = true
        view.requireSubPOIs = true
        return view
    }()
    
    lazy var poiRequset:AMapPOIAroundSearchRequest = {
        
        let view = AMapPOIAroundSearchRequest()
        view.sortrule = 0
        view.radius = 50000
        view.requireExtension = true
        view.special = true
        return view
    }()
    
    lazy var imageView:UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "mak")
        return view 
    }()
    
    
    lazy var buttonView:MapButtonView = {
        let view = MapButtonView()
        view.delegate = self
        view.SQ_debug()
        return view
    }()
    
    var isLeftBool:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "地图"
        view.SQ_addSubViews([mamapView,textfield,rightButton,imageView,buttonView])
        self.SQ_setUpLayour()
    
    }
    
    /// 搜索按钮点击
    @objc func SQ_Search() {
        isLeftBool = false
        request.keywords = textfield.text
        request.city = "成都"
        search?.aMapPOIKeywordsSearch(request)
        
    }
    
    //搜索结果
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.count == 0  {
            SQ_Toast("搜索结果为空")
            return
        }
        view.endEditing(true)
        if isLeftBool {
            
            let vc = MapSearchViewController.init()
            vc.jsonArray.addObjects(from: response.pois)
            vc.dinate = self.mamapView.centerCoordinate
            self.SQ_pushvc(vc, true)
            
            
        }else{
            let vc = MapListViewController.init()
            vc.jsonArray.addObjects(from: response.pois)
            
            self.SQ_pushvc(vc, true)
            vc.SQ_block = {(amappoi:AMapPOI) in
                let dinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(amappoi.location.latitude), CLLocationDegrees(amappoi.location.longitude))
                self.mamapView.setCenter(dinate2D, animated: true)
                
            }
        }
      
    }
    
    //地图开始滑动
    func mapView(_ mapView: MAMapView!, mapWillMoveByUser wasUserAction: Bool) {
        view.endEditing(true)
        self.buttonView.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(-70)
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
       
        
    }
    
    //地图移动结束调用此接口
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        
//        mapView.centerCoordinate
            self.buttonView.snp.updateConstraints { make in
                make.left.equalToSuperview()
            }
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
        print("2222222-----" + String(mapView.centerCoordinate.latitude) + "------" + String(mapView.centerCoordinate.longitude))
    }
    
    
    //左边按钮点击代理回调
    func SQ_save(_ index: NSInteger) {

        isLeftBool = true
        poiRequset.location = AMapGeoPoint.location(withLatitude: CGFloat(mamapView.centerCoordinate.latitude), longitude: CGFloat(mamapView.centerCoordinate.longitude))
        
        switch index {
        case 0:
            poiRequset.keywords = "医院|诊所|第一人民医院|120"
            poiRequset.types = "090100|090101|090102|090200|090300|090400"
        case 1:
            poiRequset.keywords = "消防队|119|消防大队"
            poiRequset.types = "130504"
        case 2:
             
            poiRequset.keywords = "交警|交警大队"
            poiRequset.types = "130601|130604"
        case 3:
            poiRequset.keywords = "公安局|派出所|110"
            poiRequset.types = "130501"

        case 4:
            poiRequset.keywords = "街道办|街道办事处|政务中心|政府中心"
            poiRequset.types = "130000"
        case 5:
            poiRequset.keywords = "安监局|安全生产监督管理局"
            poiRequset.types = "130000"
        default:
            print(0)
        }
        
        search?.aMapPOIAroundSearch(poiRequset)
    }
    
   
    
   
    func SQ_setUpLayour() {
        mamapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textfield.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(110)
            make.height.equalTo(40)
        }
        rightButton.snp.makeConstraints { make in
            make.top.equalTo(textfield)
            make.right.equalTo(textfield.snp.right)
            make.bottom.equalTo(textfield)
            make.width.equalTo(50)
        }
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
        }
        
        buttonView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(textfield.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.width.equalTo(70)
        }
    }
  

}
