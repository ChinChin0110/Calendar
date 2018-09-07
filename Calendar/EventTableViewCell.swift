//
//  EventTableViewCell.swift
//  Calendar
//
//  Created by Robin chin on 2018/9/6.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import UIKit

protocol CalendarCell {
    associatedtype model
    func update(_ model: model)
}

class EventTableViewCell: UITableViewCell, CalendarCell {

    typealias model = Event
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
        let size = CGSize(width: frame.width * 4 / 5 - 10, height: frame.height * 0.9)
        textLabel?.frame = CGRect(origin: origin, size: size)
    }
    
    private func setupUI() {
        selectionStyle = .none
        textLabel?.layer.backgroundColor = UIColor.init(red: 100/255, green: 192/255, blue: 37/255, alpha: 1.0).cgColor
        textLabel?.layer.cornerRadius = 3
        textLabel?.textColor = UIColor.white
        textLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    func update(_ model: Event) {
        let eventName = "Ultra Taiwan\n"
        let time = "上午11時 - 下午10時"
        let location = "大佳河濱"
        
        self.textLabel?.numberOfLines = 0
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.firstLineHeadIndent = 10
        paragraph.lineSpacing = 2
        
        let attibutes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold),
            NSAttributedStringKey.paragraphStyle: paragraph
        ]
        let attributedString = NSMutableAttributedString(string: eventName, attributes: attibutes)
        let lastString = NSAttributedString(string: "\(time) 在 \(location)", attributes: [NSAttributedStringKey.paragraphStyle: paragraph])
        attributedString.append(lastString)
        
        self.textLabel?.attributedText = attributedString
    }
}
