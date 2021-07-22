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
        
        imageViews.kf.setImage(with: URL(string: "https://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=美女&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&hd=undefined&latest=undefined&copyright=undefined&cs=1545655807,459773094&os=3475484516,1732021831&simid=3481281205,272653339&pn=188&rn=1&di=79310&ln=2000&fr=&fmq=1626862544348_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&is=0,0&istype=0&ist=&jit=&bdtype=0&spn=0&pi=0&gsm=96&objurl=https%3A%2F%2Fgimg2.baidu.com%2Fimage_search%2Fsrc%3Dhttp%253A%252F%252Fpic1.win4000.com%252Fwallpaper%252F2020-07-20%252F5f1554f6d025b.jpg%26refer%3Dhttp%253A%252F%252Fpic1.win4000.com%26app%3D2002%26size%3Df9999%2C10000%26q%3Da80%26n%3D0%26g%3D0n%26fmt%3Djpeg%3Fsec%3D1629454553%26t%3D55f04501ae9cc37f085454b1eb44dbdb&rpstart=0&rpnum=0&adpicid=0&nojc=undefined"))
      
        
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
        
        
        
//        let fullPath = NSHomeDirectory().appending("/Documents/").appending("home")
//        if let savedImage = UIImage(contentsOfFile: fullPath) {
//            imageViews.image = savedImage
////            imageViews.isHidden = false
//            label.text = "当前封面设置"
//         } else {
////            label.text = "文件不存在"
////            imageViews.isHidden = true
//             imageViews.kf.setImage(with: URL(string: "https://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=美女&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&hd=undefined&latest=undefined&copyright=undefined&cs=1545655807,459773094&os=3475484516,1732021831&simid=3481281205,272653339&pn=188&rn=1&di=79310&ln=2000&fr=&fmq=1626862544348_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&is=0,0&istype=0&ist=&jit=&bdtype=0&spn=0&pi=0&gsm=96&objurl=https%3A%2F%2Fgimg2.baidu.com%2Fimage_search%2Fsrc%3Dhttp%253A%252F%252Fpic1.win4000.com%252Fwallpaper%252F2020-07-20%252F5f1554f6d025b.jpg%26refer%3Dhttp%253A%252F%252Fpic1.win4000.com%26app%3D2002%26size%3Df9999%2C10000%26q%3Da80%26n%3D0%26g%3D0n%26fmt%3Djpeg%3Fsec%3D1629454553%26t%3D55f04501ae9cc37f085454b1eb44dbdb&rpstart=0&rpnum=0&adpicid=0&nojc=undefined"))
//         }
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
