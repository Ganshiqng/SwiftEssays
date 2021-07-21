//
//  towViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/7/13.
//

import UIKit
import JXSegmentedView
import SwiftyUserDefaults
class towViewController: BaseViewController ,JXSegmentedListContainerViewListDelegate,UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func listView() -> UIView {
        return view
    }
    
    var button = UIButton()
    var imageViews = UIImageView()
    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()

        label = UILabel()
        label.text = "当前封面设置"
        label.textColor = .lightGray
        label.font = Font_Reg_10
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(30)
        }
        
        imageViews = UIImageView()
        imageViews.contentMode = .scaleAspectFit
        view.addSubview(imageViews)
        imageViews.snp.makeConstraints { (make) in
            make.left.equalTo(label)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.width.height.equalTo(100)
        }
        
      
        
        button = UIButton()
        button.backgroundColor = UIColor.SQ_randomColor
        button.layer.cornerRadius = 20
        button.setTitle("设置", for: .normal)
        button.addTarget(self, action:#selector(setupimage), for:.touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-70)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
     }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.SQ_ViewDidLod()
    }
    
    func SQ_ViewDidLod() {
        
        
        
        let fullPath = NSHomeDirectory().appending("/Documents/").appending("home")
        if let savedImage = UIImage(contentsOfFile: fullPath) {
            imageViews.image = savedImage
            imageViews.isHidden = false
            label.text = "当前封面设置"
         } else {
            label.text = "文件不存在"
            imageViews.isHidden = true
         }
    }

   
  @objc  func setupimage()  {
        let photopicker  = UIImagePickerController()
        photopicker.delegate = self
        photopicker.allowsEditing = false
        photopicker.sourceType = .photoLibrary
        self.present(photopicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage:UIImage? = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
               if (selectedImage == nil ) {
                   selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
               }
        self.saveImage(currentImage: selectedImage!, persent: 1, imageName: "home")
        self.dismiss(animated: true, completion: nil)
    }
    
    private func saveImage(currentImage: UIImage, persent: CGFloat, imageName: String){
        if let imageData = currentImage.jpegData(compressionQuality: persent) as NSData? {
               let fullPath = NSHomeDirectory().appending("/Documents/").appending(imageName)
               imageData.write(toFile: fullPath, atomically: true)
               print("fullPath=\(fullPath)")
           }
       }

}
