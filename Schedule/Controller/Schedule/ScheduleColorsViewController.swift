//
//  ScheduleColorViewController.swift
//  Schedule
//
//  Created by Nick Khachatryan on 04.08.2024.
//

import UIKit

class ScheduleColorsViewController : UITableViewController {
    
    
    //MARK: - Private Properties
    
    private let idOptionsColorCell = "idOptionsColorCell"
    private let idOptionsScheduleHeader = "idOptionsScheduleHeader"
    
    private let headerNameArray = ["RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "DEEP BLUE", "PURPLE"]
    
    
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Colors Schedule"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.900647819, green: 0.900647819, blue: 0.900647819, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier: idOptionsColorCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsScheduleHeader)
    }
    
    
    //MARK: - Private Methods
    
    private func setColor(color : String) {
        let scheduleOptions = self.navigationController?.viewControllers[1] as? ScheduleOptionsTableViewController
        scheduleOptions?.hexColorCell = color
        scheduleOptions?.tableView.reloadRows(at: [[3,0], [4,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - TableView Methods
    
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsScheduleHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TAP")
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
}


