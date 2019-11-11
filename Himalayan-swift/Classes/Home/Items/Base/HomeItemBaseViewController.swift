//
//  TestViewController.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/2.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit
import JXCategoryView

protocol HomeContainerViewDelegate: NSObjectProtocol {
    func homeContainerViewChangeBg(pageIndex: Int ,bgColor: UIColor);
}


class HomeItemBaseViewController: UIViewController {
    
    var bgColor: UIColor = UIColor.white
    
    var pageIndex: Int = -1
    
    var isLoadData: Bool = true
    
    
    weak var delegate: HomeContainerViewDelegate?
    
    lazy var listTabView: UITableView = {
        var listTabView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
        return listTabView
    }()
    lazy var gujiaImageView: UIImageView = {
           var gujiaImageView: UIImageView = UIImageView(image: UIImage(named: "rec_flow_header_loading"))
           return gujiaImageView
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(listTabView)
        self.view.backgroundColor = UIColor.clear
        self.listTabView.tableFooterView = UIView()
        listTabView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.listTabView.backgroundColor = UIColor.clear
        //加载骨架屏
        self.listTabView.tableHeaderView = gujiaImageView
    }
}

extension HomeItemBaseViewController: JXCategoryListContentViewDelegate{
    func listView() -> UIView! {
        return view
    }
}
