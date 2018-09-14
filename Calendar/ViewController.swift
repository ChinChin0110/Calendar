//
//  ViewController.swift
//  Calendar
//
//  Created by Chin Chin on 2018/9/1.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct RegisterName {
        static let weekCell = String(describing: WeekTableViewCell.self)
        static let eventCell = String(describing: EventTableViewCell.self)
        static let calendarHeader = String(describing: CalendarHeaderView.self)
    }
    
    lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(WeekTableViewCell.self, forCellReuseIdentifier: RegisterName.weekCell)
        tableview.register(EventTableViewCell.self, forCellReuseIdentifier: RegisterName.eventCell)
        tableview.register(CalendarHeaderView.self, forHeaderFooterViewReuseIdentifier: RegisterName.calendarHeader)
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        tableview.estimatedSectionHeaderHeight = CalendarConfig.headerHeight
        tableview.sectionHeaderHeight = CalendarConfig.headerHeight
        tableview.rowHeight = CalendarConfig.rowHeight
        tableview.estimatedRowHeight = CalendarConfig.rowHeight
        tableview.sectionFooterHeight = CGFloat.leastNormalMagnitude
        return tableview
    }()
    
    let viewModel = ViewModel(yearRange: 3)
    
    private var images: [UIImage?] = {
        var images = [UIImage?]()
        for index in (1...12) {
            images.append(UIImage(named: "image-\(index).jpg"))
        }
        return images
    }()
    
    private var didShowSectionViewSet: Set<UIView> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        
        if let currentDateIndexPath = viewModel.currentDateIndexPath {
            tableView.scrollToRow(at: currentDateIndexPath, at: .middle, animated: false)
        }
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.weekModelsUpdateClosure = { [weak self] section in
            self?.tableView.reloadSections([section], with: .none)
            self?.updateSectionBackground()
        }
    }
    
    private func updateSectionBackground() {
        let contentUpperBound = tableView.contentOffset.y
        let visibleHeight = tableView.bounds.height
        didShowSectionViewSet.forEach { (view) in
            let viewPositionInVisibleHeight = view.frame.midY - contentUpperBound
            let percent = viewPositionInVisibleHeight / visibleHeight
            let _percent = max(min(percent, 1), 0)
            let _view = view as? CalendarHeaderView
            _view?.setBackgroundPosition(_percent)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.eventWeekModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RegisterName.calendarHeader)
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? CalendarHeaderView else { return }
        let monthAndYear = viewModel.monthAndYearAtSection(section)
        let image = images[monthAndYear.month - 1]
        let text = "\(monthAndYear.year)  \(monthAndYear.month)"
        header.imageView.image = image
        header.updateString(text)
        didShowSectionViewSet.insert(header)
        updateSectionBackground()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        didShowSectionViewSet.remove(view)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateSectionBackground()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel.modelTypeFor(indexPath) else { return UITableViewCell() }
        switch model {
        case .weekModel(let weekModel):
            let cell = getCell(type: model) as? WeekTableViewCell
            cell?.update(weekModel)
            return cell ?? UITableViewCell()
        case .eventModel(let event):
            let cell = getCell(type: model) as? EventTableViewCell
            cell?.update(event)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    private func getCell(type: ViewModel.ModelType) -> UITableViewCell? {
        switch type {
        case .weekModel:
            return tableView.dequeueReusableCell(withIdentifier: RegisterName.weekCell)
        case .eventModel:
            return tableView.dequeueReusableCell(withIdentifier: RegisterName.eventCell)
        }
    }
}
