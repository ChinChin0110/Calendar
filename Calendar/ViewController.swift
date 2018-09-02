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
        let tableview = UITableView()
        tableview.register(TableViewCell.self, forCellReuseIdentifier: String(describing: TableViewCell.self))
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        let indexPath = IndexPath.init(row: 5, section: 500 )
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)

        let service = CalendarService()
        service.weekModel.forEach { (model) in
            print(model.month)
            print(model.description)
            print("-----------")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1000
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self))
        cell?.textLabel?.text = "\(indexPath.section), \(indexPath.row)"
        return cell!
    }
}
