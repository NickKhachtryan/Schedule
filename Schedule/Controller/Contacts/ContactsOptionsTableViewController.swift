//
//  ContactsOptionsTableViewController.swift
//  Schedule
//
//  Created by Nick Khachatryan on 16.08.2024.
//

import UIKit

class ContactsOptionsTableViewController : UITableViewController {
    
    private let idOptionsContactsCell = "idOptionsContactsCell"
    private let idOptionsContactsHeader = "idOptionsContactsHeader"
    
    private let headerNameArray = ["NAME", "PHONE", "EMAIL", "TYPE", "IMAGE"]
    
    private let cellNameArray = ["Name", "Phone number", "Email", "Type of contact", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contact's Options"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.900647819, green: 0.900647819, blue: 0.900647819, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContactsCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsContactsHeader)

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactsCell, for: indexPath) as! OptionsTableViewCell
        cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? 200 : 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactsHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertForCellName(label: cell.nameCellLabel, name: "Contact Name", placeholder: "Enter name...") {text in print(text)}
            
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Phone number", placeholder: "Enter phone number...") {text in print(text)}
            
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Email address", placeholder: "Enter email address...") {text in print(text)}

        case 3: alertFriendOrTeacher(label: cell.nameCellLabel) { (type) in
            print(type)
        }
            
        case 4: alertPhotoOrCamera { source in
            self.chooseImagePicker(source: source)
        }
            
        default: print("tap")
        }
    }
    
//    private func pushControllers(vc: UIViewController) {
//        navigationController?.pushViewController(vc, animated: true)
//        navigationController?.navigationBar.topItem?.title = "Back"
//    }
}

extension ContactsOptionsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cell = tableView.cellForRow(at: [4, 0]) as! OptionsTableViewCell
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        dismiss(animated: true)
    }
    
}

