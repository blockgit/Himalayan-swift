//
//  HomeRecommedViewModel.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/8.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit

protocol HomeRecommedViewModelDelegate: NSObjectProtocol {
    func foucsImageColor(bgColor: UIColor);
}

class HomeRecommedViewModel: HomeItemBaseViewModel {
    
    /// 列表头部显示视图，组合显示
    lazy var headerView: UIView = {
        return UIView()
    }()
    //代理
    weak var delegate: HomeRecommedViewModelDelegate?
    
    //轮番图
    var foucsPageScrollView: HMHeadPagescrollView?
    
    
    /// 推荐的内容
    var homeRecommendModel: HomeRecommendModel?
    
    /// 加载推荐内
    /// - Parameter sucess: 推荐加载内容后回调
    func LoadData(sucess:@escaping ()->(Void)) {
        weak var weakself = self
        HMHttpAPICommon.GET(url: HomeRecommendAPI.HomeRecommendFeedLoad.path) { (json) in
            weakself?.isHavedLoadData = true
            weakself?.homeRecommendModel = HomeRecommendModel.deserialize(from: json)
            sucess()
        }
    }
    
    /// 返回列表头部视图，组合头部展示
    func loadTableHeaderView() -> UIView? {
        headerView.removeFromSuperview()
        var currentHeight: CGFloat = 0
        //组合TableView 头部
        if homeRecommendModel?.header != nil {
            let headerCount: Int = homeRecommendModel?.header?.count ?? 0
            for i in 0..<headerCount  {
                let recommendHead: HomeRecommendHead? = homeRecommendModel?.header![i]
                if recommendHead != nil {
                    let homeRecommendHeadItem: HomeRecommendHeadItem? = recommendHead?.item
                    if homeRecommendHeadItem != nil {
                        if homeRecommendHeadItem?.moduleType == HomeRecommendHeaderEnum.focus.toString {
                            if homeRecommendHeadItem?.list?.count ?? 0 > 0 {
                                let recommendFocus: HomeRecommendFocus = HomeRecommendFocus.deserialize(from: (homeRecommendHeadItem?.list?.first)!)!
                                //取第一个元素
                                let scrollHeight = (KScreenWidth * 430.0) / 1200.0
                                 //轮播图显示
                                 foucsPageScrollView = HMHeadPagescrollView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: scrollHeight))
                                foucsPageScrollView?.delegate = self
                                                            
                                foucsPageScrollView?.imageUrlModels = recommendFocus.data
                                currentHeight = currentHeight + scrollHeight
                            }
                        }
                        if homeRecommendHeadItem?.moduleType == HomeRecommendHeaderEnum.square.toString {
                            //糖葫芦/一串显示
                        }
                        if homeRecommendHeadItem?.moduleType == HomeRecommendHeaderEnum.topBuzz.toString {
                            //听头条
                            
                        }
                        if homeRecommendHeadItem?.moduleType == HomeRecommendHeaderEnum.guessYouLike.toString {
                            //猜喜欢
                            //分多行和单行展示
                            if homeRecommendHeadItem?.displayStyle == "two_line" {
                                //显示2行
                            }else{
                                //显示1行
                            }
                        }
                    }
                }
            }
        }
        if foucsPageScrollView != nil {
            headerView.addSubview(foucsPageScrollView!)
            headerView.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: currentHeight)
        }
        if currentHeight > 0 {
            return headerView
        }
        return nil
    }
    
    /// 获取section数量
    func getSectionCount() -> Int {
        return 1
    }
    /// 获取cell数量
    func getCellCount(numberOfRowsInSection section: Int) -> Int {
        if self.isHavedLoadData {
            //真实数量
            return 0
        }else{
            return self.recFlowCellCount
        }
    }
    
    /// 获取Cell 高度
    func getCellHeight() -> CGFloat {
        if self.isHavedLoadData {
            return 0
        }
        return recFlowCellHeight
    }
    
    //重写获取cell 方法
    override func getTableViewCell(tableView: UITableView,indexPath: IndexPath) -> UITableViewCell? {
        if self.isHavedLoadData {
            return nil!
        }else{
            return super.getTableViewCell(tableView: tableView,indexPath: indexPath)
        }
    }
}


extension HomeRecommedViewModel: HMHeadPagescrollViewDelegate{
    func HMHeadPagescrollViewChangeColor(bgColor: UIColor){
        if self.delegate != nil {
            self.delegate!.foucsImageColor(bgColor: bgColor)
        }
    }
}
