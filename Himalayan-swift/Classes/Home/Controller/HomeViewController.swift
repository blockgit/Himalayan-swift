//
//  HomeViewController.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/10/31.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit
import JXCategoryView


class HomeViewController: HMBaseViewController {
    lazy var homeTopView: HomeCategorySearchView = {
        return $0
    }(HomeCategorySearchView.load())
    
    /// 头部显示颜色变化的视图
    lazy var topView: UIView = {
        return $0
    }(UIView())
    
    lazy var containerView: JXCategoryListContainerView = {
        var containerView: JXCategoryListContainerView = JXCategoryListContainerView(type: JXCategoryListContainerType.scrollView, delegate: self)
        //类型必须使用scrollView,使用collectionView 无法将cell 的背景色清除
        containerView.backgroundColor = UIColor.clear
        containerView.scrollView.backgroundColor = UIColor.clear
        containerView.scrollView.bounces = true
        return containerView
    }()
    
    
    lazy var homeViewModel: HomeViewModel = {
        var homeViewModel: HomeViewModel = HomeViewModel()
        return homeViewModel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpVIew()
        weak var weakself = self
        homeViewModel.loadData {
            weakself?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK : 初始化视图
extension HomeViewController{
    
    /// 初始化视图
    func setUpVIew() {
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(250)
        }
        topView.backgroundColor = UIColor.white
        
        self.view.addSubview(homeTopView)
        homeTopView.snp.makeConstraints { (make) in
            make.top.equalTo(statusBarHeight)
            make.left.right.equalTo(0)
            make.height.equalTo(85)
        }
        self.view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(homeTopView.snp.bottom)
            make.leading.right.bottom.equalTo(0)
        }
        homeTopView.categoryView.listContainer = containerView
        homeTopView.categoryView.titles = []
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
}

//MARK : 加载数据
extension HomeViewController {
    func reloadData() {
        //构建titles 数组
        var titleNames: [String] = [String]()
        var titleImageUrls: [URL] = [URL]()
        var titleSelectImageUrls: [URL] = [URL]()
        var titleTypes: [NSNumber] = [NSNumber]()
        let categoryCount = homeViewModel.homeCategoryModel?.customCategoryList?.count ?? 0
        for index in 0..<categoryCount{
            let categoryDetailsModel: HomeCategoryDetailsModel? = homeViewModel.homeCategoryModel?.customCategoryList?[index]
            if categoryDetailsModel != nil {
                titleNames.append(categoryDetailsModel?.title ?? "")
                
                if categoryDetailsModel?.activeCoverPath != nil && categoryDetailsModel?.activeCoverPath?.count ?? 0 > 0 {
                    titleTypes.append(NSNumber(integerLiteral: Int(JXCategoryTitleImageType.onlyImage.rawValue)))
                    titleImageUrls.append(URL(string: categoryDetailsModel?.activeCoverPath ?? "")!)
                    titleSelectImageUrls.append(URL(string: categoryDetailsModel?.unactiveCoverPath ?? "")!)
                }else{
                    titleImageUrls.append(URL(fileURLWithPath: categoryDetailsModel?.activeCoverPath ?? ""))
                    titleSelectImageUrls.append(URL(fileURLWithPath: categoryDetailsModel?.unactiveCoverPath ?? ""))
                    titleTypes.append(NSNumber(integerLiteral: Int(JXCategoryTitleImageType.onlyTitle.rawValue)))
                    
                }
            }
        }
        homeTopView.categoryView.loadImageCallback = {
            (image , url) in
            if !(url?.downloadURL.absoluteString.contains("file:///") ?? false) {
                image?.kf.setImage(with: url)
            }
        }
        homeTopView.categoryView.titles = titleNames
        homeTopView.categoryView.imageURLs = titleImageUrls
        homeTopView.categoryView.selectedImageURLs = titleSelectImageUrls
        homeTopView.categoryView.imageTypes = titleTypes
        homeTopView.categoryView.reloadData()
    }
}

extension HomeViewController: JXCategoryListContainerViewDelegate{
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return homeViewModel.homeCategoryModel?.customCategoryList?.count ?? 0
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        let categoryDetailsModel: HomeCategoryDetailsModel? = homeViewModel.homeCategoryModel?.customCategoryList?[index]
        let itemType: String = categoryDetailsModel?.itemType ?? HomeCategory.single_category.toString
        if itemType == HomeCategory.recommend.toString{//推荐
            let hmRecommendVC: HMRecommendViewController = HMRecommendViewController()
            hmRecommendVC.delegate = self
            hmRecommendVC.pageIndex = index
            return hmRecommendVC
        }
        return ExampleViewController()
    }
}

extension HomeViewController: HomeContainerViewDelegate{
    func homeContainerViewChangeBg(pageIndex: Int, bgColor: UIColor) {
        if homeTopView.categoryView.selectedIndex == pageIndex {
            topView.backgroundColor = bgColor
        }
    }
}
