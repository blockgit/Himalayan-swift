//
//  HMHeadPagescrollView.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/9.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit
import JXCategoryView

protocol HMHeadPagescrollViewDelegate: class {
    func HMHeadPagescrollViewChangeColor(bgColor: UIColor)
}

class HMHeadPagescrollView: UIView {
    weak var delegate: HMHeadPagescrollViewDelegate?
    
    var imageUrlModels: [HomeRecommendFocusDetails]? = []{
        didSet{
            pageScrolleView.orginPageCount = imageUrlModels?.count ?? 0
            pageScrolleView.needsReload = true
            pageScrolleView.reloadData()
        }
    }
    
    lazy var pageControl: UIPageControl = {
        var pageControl: UIPageControl = UIPageControl(frame: CGRect(x: (self.frame.width - 180) * 0.5, y: self.frame.height - 8 - 15, width: 180, height: 15))
        pageControl.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        pageControl.layer.cornerRadius = 7.5
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return pageControl
    }()
    
    lazy var pageScrolleView: NewPagedFlowView = {
        var pageScrolleView: NewPagedFlowView = NewPagedFlowView(frame: self.bounds)
        pageScrolleView.delegate = self
        pageScrolleView.dataSource = self
        pageScrolleView.backgroundColor = UIColor.clear
        pageScrolleView.minimumPageAlpha = 0.4
        pageScrolleView.leftRightMargin = 35;
        pageScrolleView.topBottomMargin = 15;
        pageScrolleView.autoTime = 3.0
        pageScrolleView.orginPageCount = imageUrlModels?.count ?? 0;
        pageScrolleView.pageControl = pageControl
        pageScrolleView.addSubview(pageControl)
        return pageScrolleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //加载视图
        self.addSubview(pageScrolleView)
        //添加通知监听
        NotificationCenter.default.addObserver(self, selector: #selector(notifyTimer(any:)), name: NSNotification.Name(rawValue: FocusTimerNotiyName), object: nil)
    }
    
    @objc func notifyTimer(any: Notification) {
        if any.object != nil {
            if any.object as! Bool == true  {
                //开启定时器
                pageScrolleView.startTimer()
            }else{
                //关闭定时器
                pageScrolleView.stopTimer()
//
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HMHeadPagescrollView: NewPagedFlowViewDelegate,NewPagedFlowViewDataSource{
    func numberOfPages(in flowView: NewPagedFlowView!) -> Int {
        return imageUrlModels?.count ?? 0
    }
    
    func flowView(_ flowView: NewPagedFlowView!, cellForPageAt index: Int) -> PGIndexBannerSubiew! {
        var bannerView: PGIndexBannerSubiew? = flowView.dequeueReusableCell()
        if bannerView == nil {
            bannerView = PGIndexBannerSubiew()
            bannerView!.layer.cornerRadius = 4.0
            bannerView!.layer.masksToBounds = true;
        }
        let focusDetailsModel: HomeRecommendFocusDetails? = imageUrlModels?[index] ?? nil
        if focusDetailsModel != nil && focusDetailsModel!.cover != nil {
            bannerView?.mainImageView.kf.setImage(with: URL(string: focusDetailsModel!.cover!), placeholder: UIImage(named: "BannerDefault"), completionHandler: {[weak self] (result) in
                if bannerView?.mainImageView.image != nil {
                    focusDetailsModel?.titleBgColor = LightImageColor.mostColor((bannerView?.mainImageView.image)!)
                    if index == self?.pageScrolleView.currentPageIndex {
                        if self?.delegate != nil {
                            self?.delegate!.HMHeadPagescrollViewChangeColor(bgColor: focusDetailsModel?.titleBgColor ?? UIColor.white)
                        }
                    }
                }
            })
            focusDetailsModel?.titleBgColor = LightImageColor.mostColor((bannerView?.mainImageView.image)!)
        }else{
            bannerView?.mainImageView.image = UIImage(named: "BannerDefault")
        }
        
        return bannerView
    }
    
    func sizeForPage(in flowView: NewPagedFlowView!) -> CGSize {
        return CGSize(width: self.frame.width - 30, height: self.frame.height)
    }
    
    
    /// 滚动到某个页面
    /// - Parameters:
    ///   - pageNumber: 页码
    ///   - flowView: flowView description
    func didScroll(toPage pageNumber: Int, in flowView: NewPagedFlowView!) {
        let focusDetailsModelStart: HomeRecommendFocusDetails? = imageUrlModels?[pageNumber] ?? nil
        if focusDetailsModelStart != nil {
            //显示颜色
            if self.delegate != nil {
                self.delegate!.HMHeadPagescrollViewChangeColor(bgColor: focusDetailsModelStart?.titleBgColor ?? UIColor.white)
            }
        }
    }
    //滚动到随图片颜色变化
    func didScroll(with flowView: NewPagedFlowView!, andScrollView scrollView: UIScrollView!) {
        if !(imageUrlModels != nil && imageUrlModels!.count > 0) {
            return
        }
        let offsetX: CGFloat = scrollView.contentOffset.x
        let maxOffsetX: CGFloat = CGFloat((imageUrlModels!.count)) * scrollView.frame.width
        let changeOffsetX: CGFloat = offsetX - maxOffsetX;
        //在第一张图往右滑，显示最后一张时为负数
        var firstGotoBack: Bool = false
        if changeOffsetX < 0 {
            firstGotoBack = true
        }
        var ratio: CGFloat = (changeOffsetX / scrollView.frame.width)
        if ratio < 0 || ratio > CGFloat(imageUrlModels!.count) {
            //越界获取索引不对
            return
        }
        //计算滑动的百分比
        ratio = max(0, min(ratio, CGFloat(imageUrlModels!.count)))
        var firstIndex: Int = Int(floorf(Float(ratio)))
        if firstIndex >=  imageUrlModels!.count {
            firstIndex = 0
        }
        //滑动到另一个位置的百分比
        let remainderRatio: CGFloat = ratio - CGFloat(firstIndex)
        if remainderRatio < 0 || remainderRatio > 1{
            return
        }
        var secondIndex: Int = 0
        if firstGotoBack {
            secondIndex = imageUrlModels!.count - 1
        }else if(firstIndex == (imageUrlModels!.count - 1)){
            secondIndex = 0
        }else{
            secondIndex = firstIndex + 1
        }
        let focusDetailsModelStart: HomeRecommendFocusDetails? = imageUrlModels?[firstIndex] ?? nil
        let focusDetailsModelEnd: HomeRecommendFocusDetails? = imageUrlModels?[secondIndex] ?? nil
        let startColor: UIColor = focusDetailsModelStart?.titleBgColor ?? UIColor.lightGray
        let endColor: UIColor = focusDetailsModelEnd?.titleBgColor ?? UIColor.lightGray
        let bgColor: UIColor = JXCategoryFactory.interpolationColor(from: startColor, to: endColor, percent: remainderRatio)
        //显示颜色
        if self.delegate != nil {
            self.delegate!.HMHeadPagescrollViewChangeColor(bgColor: bgColor)
        }
    }
}
