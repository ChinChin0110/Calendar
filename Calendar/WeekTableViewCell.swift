//
//  TableViewCell.swift
//  Calendar
//
//  Created by Chin Chin on 2018/9/1.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import UIKit

class WeekTableViewCell: UITableViewCell, CalendarCell {

    typealias model = CalendarWeekModel
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let origin = CGPoint(x: frame.width / 5, y: 0)
        let size = CGSize(width: frame.width * 4 / 5, height: frame.height)
        textLabel?.frame = CGRect(origin: origin, size: size)
    }
    
    private func setupUI() {
        selectionStyle = .none
        textLabel?.textColor = UIColor.lightGray
        textLabel?.font = UIFont.systemFont(ofSize: 10)
    }
    
    func update(_ model: CalendarWeekModel) {
        self.textLabel?.text = model.description
    }
}
