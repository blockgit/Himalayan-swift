//
//  HomeItemBaseViewModel.swift
//  Himalayan-swift
//
//  Created by 毛永绪 on 2019/11/8.
//  Copyright © 2019 毛永绪. All rights reserved.
//

import UIKit

class HomeItemBaseViewModel {
    
    /// 骨架屏显示cell数量
    var recFlowCellCount: Int = 5
    
    /// 骨架屏cell的高度
    var recFlowCellHeight: CGFloat = 129.0
    
    /// 是否已加载数据，显示骨架屏
    var isHavedLoadData: Bool = false
    
    
    /// 获取骨架屏的cell
    /// - Parameter tableView: 显示内容的tableView
    /// - Parameter indexPath: 显示内容的indexPath
    func getTableViewCell(tableView: UITableView,indexPath: IndexPath) -> UITableViewCell? {
        var cell: HomeRecFlowCell? = tableView.dequeueReusableCell(withIdentifier: "HomeRecFlowCell") as? HomeRecFlowCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("HomeRecFlowCell", owner: nil, options: nil)?.last as? HomeRecFlowCell
        }
        return cell!
    }
}
