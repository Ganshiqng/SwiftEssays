//
//  CyclescrollViewController.swift
//  demo
//
//  Created by 甘世清 on 2021/7/27.
//

import UIKit
import JXSegmentedView
import SDCycleScrollView
class CyclescrollViewController: BaseViewController ,JXSegmentedListContainerViewListDelegate,SDCycleScrollViewDelegate{
    
    func listView() -> UIView {
        return view
    }

    lazy var bannerView:SDCycleScrollView = {
        let view:SDCycleScrollView = SDCycleScrollView(frame: CGRect.zero , delegate: self, placeholderImage: nil)
        view.bannerImageViewContentMode = .scaleAspectFit
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let imageArray:NSMutableArray = ["https://img2.baidu.com/it/u=4139650344,3481752645&fm=26&fmt=auto&gp=0.jpg","https://img2.baidu.com/it/u=99845787,2849762690&fm=26&fmt=auto&gp=0.jpg","https://img0.baidu.com/it/u=649913551,2779849400&fm=26&fmt=auto&gp=0.jpg","https://gimg2.baidu.com/image_search/src=http%3A%2F%2Finews.gtimg.com%2Fnewsapp_bt%2F0%2F11972243745%2F641.jpg&refer=http%3A%2F%2Finews.gtimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629960525&t=dc659a6816c0c5a92cf5699ad1dc55fb","https://pics6.baidu.com/feed/30adcbef76094b367b2526964c8edbdf8c109ddb.jpeg?token=50d80a77d4ae4fccd598274bd9bafda9"]
        
        bannerView.imageURLStringsGroup = imageArray as? [Any]
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print("00000000000-------", index)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bannerView.adjustWhenControllerViewWillAppera()
        bannerView.autoScroll = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        bannerView.autoScroll = false
    }

}
