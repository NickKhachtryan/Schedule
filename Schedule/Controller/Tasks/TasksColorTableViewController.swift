//
//  ColorTaskTableViewController.swift
//  Schedule
//
//  Created by Nick Khachatryan on 14.08.2024.
//

import UIKit

class TasksColorTableViewController : UITableViewController {
    
    private let idOptionsColorCell = "idOptionsColorCell"
    private let idOptionsTasksHeader = "idOptionsTasksHeader"
    
    private let headerNameArray = ["RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "DEEP BLUE", "PURPLE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "Color Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.900647819, green: 0.900647819, blue: 0.900647819, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier: idOptionsColorCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsTasksHeader)

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsColorCell, for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsTasksHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            setColor(color: "FF443B")
        case 1:
            setColor(color: "FF823B")
        case 2:
            setColor(color: "FFE83B")
        case 3:
            setColor(color: "2EBC5A")
        case 4:
            setColor(color: "00C8F7")
        case 5:
            setColor(color: "0081FF")
        case 6:
            setColor(color: "DE6CFF")
        default:
            setColor(color: "FFFFFF")
        }
    }
    
    private func setColor(color: String){
        let taskOptions = navigationController?.viewControllers[1] as! TaskOptionsTableViewController
        taskOptions.hexColor = color
        taskOptions.tableView.reloadRows(at: [[3,0]], with: .none)
        navigationController?.popViewController(animated: true)
    }
    
}

    
