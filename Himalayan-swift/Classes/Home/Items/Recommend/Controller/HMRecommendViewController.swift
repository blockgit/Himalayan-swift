//
//  HMRecommendViewController.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/5.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit

class HMRecommendViewController: HomeItemBaseViewController {
    
    /// ViewModel
    lazy var homeRcommedViewModel: HomeRecommedViewModel = {
        var homeRcommedViewModel: HomeRecommedViewModel = HomeRecommedViewModel()
        homeRcommedViewModel.delegate = self
        return homeRcommedViewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTabView.delegate = self
        self.listTabView.dataSource = self
        //加载推荐数据
        homeRcommedViewModel.LoadData {[weak self] () -> (Void) in
            self?.listTabView.tableHeaderView = self?.homeRcommedViewModel.loadTableHeaderView()
            self?.listTabView.reloadData()
        }
    }
}

extension HMRecommendViewController: HomeRecommedViewModelDelegate{
    func foucsImageColor(bgColor: UIColor) {
        self.bgColor = bgColor
        //继续上报颜色
        if self.delegate != nil {
            self.delegate!.homeContainerViewChangeBg(pageIndex: pageIndex, bgColor: self.bgColor)
        }
    }
}

extension HMRecommendViewController: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeRcommedViewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeRcommedViewModel.getCellCount(numberOfRowsInSection: section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return homeRcommedViewModel.getCellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return homeRcommedViewModel.getTableViewCell(tableView: tableView,indexPath: indexPath) ?? nil!
    }
}
