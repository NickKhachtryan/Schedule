//
//  TaskOptionsTableView.swift
//  Schedule
//
//  Created by Nick Khachatryan on 14.08.2024.
//


import UIKit

class TaskOptionsTableViewController : UITableViewController {
    
    private let idOptionsTasksCell = "idOptionsTasksCell"
    private let idOptionsTasksHeader = "idOptionsTasksHeader"
    
    private let headerNameArray = ["DATE", "LESSON", "TASK", "COLOR"]
    private let cellNameArray = ["Date", "Lesson", "Task", ""]
    
    var hexColor = "FF443B"
    
    private var taskModel = TaskModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Task Options"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.900647819, green: 0.900647819, blue: 0.900647819, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsTasksCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsTasksHeader)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
        
    }
    
    @objc func saveButtonTapped(){
        if taskModel.taskDate == nil || taskModel.taskName == "" {
            alertSaveOrError(title: "Error", message: "Required fields")
        } else {
            taskModel.taskColor = hexColor
            RealmManager.shared.saveTaskModel(model: taskModel)
            taskModel = TaskModel()
            alertSaveOrError(title: "Success", message: "Info saved succesfully")
            var hexColor = "FF443B"
            tableView.reloadData()
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTasksCell, for: indexPath) as! OptionsTableViewCell
        cell.cellTasksConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColor)
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
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertDate(label: cell.nameCellLabel) { (numberweekday, date)
            in
            self.taskModel.taskDate = date
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Lesson Name", placeholder: "Enter lesson name") { text
            in
            self.taskModel.taskName = text
        }
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Task Name", placeholder: "Enter task name") { text
            in
            self.taskModel.taskDescription = text
        }
        case 3: pushControllers(vc: TasksColorTableViewController())
            
        default: print("Tap TaskOptionsTableView")
        }
    }
    
    private func pushControllers(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.topItem?.title = "Back"
    }
}

