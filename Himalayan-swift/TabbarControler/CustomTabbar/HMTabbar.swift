//
//  HMTabbar.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/10/30.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit

protocol HMTabbarDelegate: class {
    
    /// 选择某项Tabbar
    /// - Parameter index: 索引
    func HMTabbarSelectIndex(index: Int)
    
    /// 点击Tabbar中间按钮
    func HMTabbarCenterClick()
}

class HMTabbar: UITabBar {
    
    weak var tabbarDelegate: HMTabbarDelegate?
    
    /// 首页-显示动画的ImageView
    @IBOutlet weak var homeAnimateImage: UIImageView!
    
    /// 我听-显示动画的ImageView
    @IBOutlet weak var myTingAnimateImage: UIImageView!
    
    /// 发现-显示动画的ImageView
    @IBOutlet weak var findAnimateImage: UIImageView!
    
    /// 登录-显示动画的ImageView
    @IBOutlet weak var meAnimateImage: UIImageView!
    
    /// 首页标签
    @IBOutlet weak var homeLabel: UILabel!
    
    /// 我听标签
    @IBOutlet weak var myTingLabel: UILabel!
    
    /// 发现标签
    @IBOutlet weak var findLabel: UILabel!
    
    /// 我的标签
    @IBOutlet weak var meLabel: UILabel!
    
    
    /// 当前播放的节目图片
    @IBOutlet weak var playImage: UIImageView!
    
    /// 选中的索引，默认是0
    var selectIndex: Int = 0
    
    /// 图片前缀
    let imageNomalName: [String] = ["tab_home_","tab_hear_","tab_find_","tab_me_"]
    
    /// 存储图片控件数组
    lazy var imageViews: [UIImageView] = {
      return [UIImageView]()
    }()
    /// 存储标题控件数组
    lazy var labels: [UILabel] = {
       return [UILabel]()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initAnimatesData()
    }
    
    /// 快速初始化
    class func tabbar()-> HMTabbar {
        let tabbarInstance: HMTabbar = Bundle.main.loadNibNamed("HMTabbar", owner: nil, options: nil)?.last as! HMTabbar
        return tabbarInstance
        
    }
    
    /// 选择tabbar菜单
    /// - Parameter sender: 按钮事件源
    @IBAction func tabbarItemClick(_ sender: UIButton) {
        if sender.tag != selectIndex{
            selectItem(index: sender.tag,oldIndex: selectIndex)
            selectIndex = sender.tag
        }
    }
}

// MARK:初始化数据 和 事件
extension HMTabbar{
    
    /// 初始化动画数据
    func initAnimatesData() {
        imageViews = [homeAnimateImage,myTingAnimateImage,findAnimateImage,meAnimateImage]
        labels = [homeLabel,myTingLabel,findLabel,meLabel]
        for label in labels {
            label.textColor = UIColor.tabbarNomalColor
        }
        for i in 0..<imageViews.count {
            let imageView: UIImageView = imageViews[i]
            var nomalImageName = imageNomalName[i]
            nomalImageName.append("1")
            imageView.image = UIImage(named: nomalImageName)
            var animateNamesArray = [UIImage]()
            for index in 2...15 {//2-15的下标索引是动画图片
                var animateImageName = imageNomalName[i]
                animateImageName.append("\(index)")
                animateNamesArray.append(UIImage(named: animateImageName) ?? UIImage())
            }
            imageView.animationImages = animateNamesArray
            imageView.animationDuration = 0.8
            imageView.animationRepeatCount = 1
        }
        //默认选中第一项
        if selectIndex < labels.count && selectIndex < imageViews.count{
            labels[selectIndex].textColor = UIColor.tabbarSelectColor
            var selImageName = imageNomalName[selectIndex]
            selImageName.append("15")
            imageViews[selectIndex].image = UIImage(named: selImageName)
            imageViews[selectIndex].startAnimating()
        }
    }
    
    /// 选中某项
    /// - Parameter index: 当前操作的索引
    /// - Parameter oldIndex: 之前操作的索引
    func selectItem(index: Int,oldIndex: Int) {
        if (index < labels.count && index < imageViews.count) && (oldIndex < labels.count && oldIndex < imageViews.count){
            labels[oldIndex].textColor = UIColor.tabbarNomalColor
            labels[index].textColor = UIColor.tabbarSelectColor
            let currentImageView: UIImageView = imageViews[index]
            let oldImageView: UIImageView = imageViews[oldIndex]
            
            var orgImageName = imageNomalName[oldIndex]
            orgImageName.append("1")
            oldImageView.image = UIImage(named: orgImageName)
            var selImageName = imageNomalName[index]
            selImageName.append("15")
            currentImageView.image = UIImage(named: selImageName)
            
            if oldImageView.isAnimating {
                oldImageView.stopAnimating()
            }
            currentImageView.startAnimating()
            if self.tabbarDelegate != nil {
                self.tabbarDelegate?.HMTabbarSelectIndex(index: index)
            }
        }
    }
    
}
