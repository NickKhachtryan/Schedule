//
//  OptionsScheduleViewController.swift
//  Schedule
//
//  Created by Nick Khachatryan on 20.06.2024.
//

import UIKit
import RealmSwift

class ScheduleOptionsTableViewController : UITableViewController {
    
    
    //MARK: - Private Properties
    
    private let idOptionsScheduleCell = "idOptionScheduleCell"
    private let idOptionsScheduleHeader = "idOptionsScheduleHeader"
    
    private let headerNameArray = ["DATE AND TIME", "SUBJECT", "TEACHER", "COLOR", "PERIOD"]
    
    private var dateSchedule: Date?
    private var timeSchedule: Date?
    
    
    //MARK: - Public Properties
    
    var cellNameArray = [["Date", "Time"],
                         ["Name", "Type", "Building", "Audience"],
                         ["Teacher Name"],
                         [""],
                         ["Repeat every 7 days"]]
    
    var scheduleModel = ScheduleModel()
    
    var editModel = false
    
    var hexColorCell = "FF443B"
    
    var switchIsOn = true

    var numberWeekdaySchedule : Int?
    
    
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Options Schedule"
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.900647819, green: 0.900647819, blue: 0.900647819, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsScheduleCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsScheduleHeader)
                
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
    }
    
    
    //MARK: - Buttons
    
    @objc private func saveButtonTapped() {
        if dateSchedule == nil || timeSchedule == nil || cellNameArray[1][0] == "Name" {
            alertSaveOrError(title: "Error", message: "Fill in Date | Time | Name")
        } else if editModel == false {
            setModel()
            RealmManager.shared.saveScheduleModel(model: scheduleModel)
            scheduleModel = ScheduleModel()
            
            navigationController?.popViewController(animated: true)
            tableView.reloadData()
        } else {
            RealmManager.shared.editScheduleModel(model: scheduleModel,
                                                  nameArray: cellNameArray,
                                                  bool: switchIsOn,
                                                  date: dateSchedule,
                                                  time: timeSchedule,
                                                  numberWeekday: numberWeekdaySchedule!,
                                                  cellColor: hexColorCell)
            
            navigationController?.popViewController(animated: true)
        }
    }

    
    //MARK: - Private Methods
    
    private func setModel(){
        scheduleModel.scheduleDate = dateSchedule
        scheduleModel.scheduleTime = timeSchedule
        scheduleModel.scheduleName = cellNameArray[1][0]
        scheduleModel.scheduleType = cellNameArray[1][1]
        scheduleModel.scheduleBuilding = cellNameArray[1][2]
        scheduleModel.scheduleAudience = cellNameArray[1][3]
        scheduleModel.scheduleTeacher = cellNameArray[2][0]
        scheduleModel.scheduleColor = hexColorCell
        scheduleModel.scheduleRepeat = switchIsOn
        scheduleModel.scheduleWeekday = numberWeekdaySchedule!
    }
    
    
    //MARK: - Table View Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 4
        case 2: return 1
        case 3: return 1
        default:
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsScheduleCell, for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell, switchRepeat: switchIsOn)
        if dateSchedule == nil {
            dateSchedule = scheduleModel.scheduleDate
        } else if timeSchedule == nil {
            timeSchedule = scheduleModel.scheduleTime
        }
        cell.switchRepeatDelegate = self
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
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath {
        case [0,0]: alertDate(label: cell.nameCellLabel) { (numberweekday, date)
            in
            
            self.dateSchedule = date
            self.numberWeekdaySchedule = numberweekday
        }
        case [0,1]: alertTime(label: cell.nameCellLabel) { (time) in
            self.timeSchedule = time
        }
            
        case [1,0]: alertForCellName(label: cell.nameCellLabel, name: "Subject Name", placeholder: "Enter lesson name") {text in 
            self.cellNameArray[1][0] = text
        }
        case [1,1]: alertForCellName(label: cell.nameCellLabel, name: "Type", placeholder: "Enter type of lesson") {text in 
            self.cellNameArray[1][1] = text
        }
        case [1,2]: alertForCellName(label: cell.nameCellLabel, name: "Building number", placeholder: "Enter number of building") {text in 
            self.cellNameArray[1][2] = text
        }
        case [1,3]: alertForCellName(label: cell.nameCellLabel, name: "Audience number", placeholder: "Enter number of audience") {text in
            self.cellNameArray[1][3] = text
        }
            
        case [2,0]: alertForCellName(label: cell.nameCellLabel, name: "Teacher name", placeholder: "Enter teacher's name") { text in
            self.cellNameArray[2][0] = text
        }

        case [3,0]: pushControllers(vc: ScheduleColorsViewController())
            
        default: print("Tap OptionsTableView")
        }
    }
    
    func pushControllers(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.topItem?.title = "Back"
    }
}


//MARK: - Switch Protocols

extension ScheduleOptionsTableViewController: SwitchRepeatProtocol{
    func SwitchRepeatProtocol(value: Bool) {
        switchIsOn = value
    }
}



    
    

