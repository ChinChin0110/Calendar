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
        return tableview
    }()
    
    let viewModel = ViewModel(yearRange: 2)
    
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
            print(section)
            self?.tableView.reloadSections([section], with: .automatic)
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
        let month = viewModel.eventWeekModels[section].first?.calendarWeekModel.month ?? -1
        let year = viewModel.eventWeekModels[section].first?.calendarWeekModel.year ?? -1
        let label = UILabel(frame: CGRect.init(origin: .zero, size: CGSize.init(width: 50, height: 50)))
        label.backgroundColor = .red
        label.text = "\(year)  \(month)"
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeekTableViewCell.self))
        
        guard let model = viewModel.modelTypeFor(indexPath) else { return cell! }
        
        var text = ""
        switch model {
        case .weekModel(let weekModel):
            text = weekModel.description
        case .eventModel(let event):
            text = event.id
        }
        cell?.textLabel?.text = text
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
