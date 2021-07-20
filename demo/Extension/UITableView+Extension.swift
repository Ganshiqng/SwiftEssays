//
//  UITableView+Extension.swift
//  demo
//
//  Created by 甘世清 on 2021/7/19.
//

import UIKit

extension String {
    public var Length:Int {
        get{
            return self.count
        }
    }
}


/// 向tableview 注册tableviewcell
/// - Parameters:
///   - tableView: tableView description
///   - cell: 要注册的类名
/// - Returns: description
func regClass(_ tableView :  UITableView , cell : AnyClass) -> Void {
    tableView.register(cell, forCellReuseIdentifier: "\(cell)")
}



/// 从tableview缓存中获取出对应的cell
/// - Parameters:
///   - tableView: tableView description
///   - cell: 要返回的cell类型
///   - indexPath: 位置
/// - Returns: 传入cell类型的实例对象
func getCell<T : UITableViewCell>(_ tableView:UITableView, cell:T.Type,indexPath:IndexPath) -> T {
    return tableView.dequeueReusableCell(withIdentifier: "\(cell)", for: indexPath) as! T
}

extension UITableView {
    func HL_scrollToBottom() {
        let section = self.numberOfSections - 1
        let row = self.numberOfRows(inSection: section) - 1
        if section < 0 || row < 0 {
            return
        }
        let path = IndexPath(row: row, section: section)
        self.scrollToRow(at: path, at: .top, animated: false)
    }
    func extRegistCell(_ cells:[AnyClass], _ identifiers : [String]){
        for i in 0 ..< cells.count {
            self.register(cells[i], forCellReuseIdentifier: identifiers[i])
        }
    }
}
