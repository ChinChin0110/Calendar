//
//  MonthView.swift
//  Calendar
//
//  Created by Robin chin on 2018/9/6.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import UIKit

class CalendarHeaderView: UITableViewHeaderFooterView {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        self.imageHeight = self.viewheight * 1.5
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    let viewheight = CalendarConfig.headerHeight
    let imageHeight: CGFloat

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let origin = CGPoint(x: frame.width / 5, y: 0)
        let size = CGSize(width: frame.width * 4 / 5, height: frame.height / 3)
        
        label.frame = CGRect(origin: origin, size: size)
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: frame.width, height: imageHeight))
    }
    
    func updateString(_ string: String) {
        label.text = string
    }
    
    func setBackgroundPosition(_ percent: CGFloat) {
        let space = imageHeight - viewheight
        let origin = CGPoint(x: 0, y: space * percent - space)
        self.imageView.frame = CGRect(origin: origin, size: imageView.frame.size)
    }
}
