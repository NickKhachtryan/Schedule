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
    
    var cellNameArray = ["Name", "Phone number", "Email", "Type of contact", ""]
    
    var contactsModel = ContactsModel()
    var editModel = false
    
    var imageIsChosen = false
    
    var dataImage: Data?
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc func saveButtonTapped(){
        if cellNameArray[0] == "Name" || cellNameArray[3] == "Type of contact"  || (cellNameArray[1] == "Phone number" && cellNameArray[2] == "Email" ) {
            alertSaveOrError(title: "Error", message: "Required fields ")
        } else if editModel == false{
            setImageModel()
            setModel()
            RealmManager.shared.saveContactsModel(model: contactsModel)
            contactsModel = ContactsModel()
            navigationController?.popViewController(animated: true)
        } else {
            setImageModel()
            RealmManager.shared.editContactsModel(model: contactsModel, nameArray: cellNameArray, imageData: dataImage)
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func setModel() {
        contactsModel.contactsName = cellNameArray[0]
        contactsModel.contactsPhoneNumber = cellNameArray[1]
        contactsModel.contactsEmail = cellNameArray[2]
        contactsModel.contactsType = cellNameArray[3]
        contactsModel.contactsImage = dataImage
    }
    
    func setImageModel(){
        if imageIsChosen {
            let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
    
            let image = cell.backgroundViewCell.image
            guard let imageData = image?.pngData() else {return}
            dataImage = imageData
            
            cell.contentMode = .scaleAspectFit
            imageIsChosen = false
            
        } else {
            dataImage = nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactsCell, for: indexPath) as! OptionsTableViewCell
        
        if editModel == false {
            cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        } else if let data = contactsModel.contactsImage, let image = UIImage(data: data) {
            cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath, image: image)
        } else {
            cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? (tableView.frame.width - 20) : 44
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
        case 0: alertForCellName(label: cell.nameCellLabel, name: "Contact Name", placeholder: "Enter name...") {text in
//            self.contactsModel.contactsName = text
            self.cellNameArray[0] = text
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Phone number", placeholder: "Enter phone number...") {text in
//            self.contactsModel.contactsPhoneNumber = text
            self.cellNameArray[1] = text
        }
            
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Email address", placeholder: "Enter email address...") {text in
//            self.contactsModel.contactsEmail = text
            self.cellNameArray[2] = text
        }

        case 3: alertFriendOrTeacher(label: cell.nameCellLabel) { (type) in
//            self.contactsModel.contactsType = type
            self.cellNameArray[3] = type
        }
            
        case 4: alertPhotoOrCamera { source in
            self.chooseImagePicker(source: source)
        }
            
        default: print("tap")
        }
    }
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
        imageIsChosen = true
        dismiss(animated: true)
    }
}

