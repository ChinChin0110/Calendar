//
//  ViewController.swift
//  Calendar
//
//  Created by Chin Chin on 2018/9/1.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(WeekTableViewCell.self, forCellReuseIdentifier: String(describing: WeekTableViewCell.self))
        tableview.register(EventTableViewCell.self, forCellReuseIdentifier: String(describing: EventTableViewCell.self))
        tableview.register(CalendarHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: CalendarHeaderView.self))
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        tableview.estimatedSectionHeaderHeight = UIScreen.main.bounds.height / 4.5
        tableview.rowHeight = 60
        tableview.estimatedRowHeight = 60
        tableview.sectionHeaderHeight = UIScreen.main.bounds.height / 4.5
        return tableview
    }()
    
    let viewModel = ViewModel(yearRange: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        
        if let currentDateIndexPath = viewModel.currentDateIndexPath {
            tableView.scrollToRow(at: currentDateIndexPath, at: .top, animated: false)
        }
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.weekModelsUpdateClosure = { [weak self] section in
            self?.tableView.reloadSections([section], with: .none)
        }
    }
    
    var images: [UIImage] = {
        var images = [UIImage]()
        for index in (1...12) {
            images.append(UIImage(named: "image-\(index).jpg")!)
        }
        return images
    }()
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.eventWeekModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let monthAndYear = viewModel.monthAndYearAtSection(section)
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: CalendarHeaderView.self)) as? CalendarHeaderView
        let image = images[monthAndYear.month - 1]
        header?.imageView.image = image
        let text = "\(monthAndYear.year)  \(monthAndYear.month)"
        header?.updateString(text)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel.modelTypeFor(indexPath) else { return UITableViewCell() }
        switch model {
        case .weekModel(let weekModel):
            let cell = getCell(type: model) as? WeekTableViewCell
            cell?.update(weekModel)
            return cell!
        case .eventModel(let event):
            let cell = getCell(type: model) as? EventTableViewCell
            cell?.update(event)
            return cell!
        }
    }
    
    private func getCell(type: ViewModel.ModelType) -> UITableViewCell? {
        switch type {
        case .weekModel:
            return tableView.dequeueReusableCell(withIdentifier: String(describing: WeekTableViewCell.self))
        case .eventModel:
            return tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCell.self))
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
