//
//  oneViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/7/8.
//

import UIKit
import JXSegmentedView

class oneViewController: UIViewController ,JXSegmentedListContainerViewListDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var index:NSInteger = 0
    
    func listView() -> UIView {
        return view
    }
    
    var button = UIButton()
    var topView = ImageTopView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        switch index {
        case 0:
            view.backgroundColor = UIColor.white
        case 1:
            view.backgroundColor = UIColor.lightGray
        default:
            view.backgroundColor = UIColor.red
        }
        

        // Do any additional setup after loading the view.
        button = UIButton()
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 22;
        button.setTitle("拍照", for: .normal)
        button.addTarget(self, action:#selector(goCamera), for:.touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-70)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
    
    }
    
    @objc  func goCamera()  {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            
            self.present(cameraPicker, animated: true, completion: nil)
            let TopView = ImageTopView()
            
            cameraPicker.view.addSubview(TopView)
            TopView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }else
        {
            print("无法拍照")
        }
    }
    
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image : UIImage = info[UIImagePickerController.InfoKey.originalImage ] as! UIImage
        
        self.dismiss(animated: true, completion: nil)
    }

}