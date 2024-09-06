//
//  HeaderOptionsScheduleTableViewCell.swift
//  Schedule
//
//  Created by Nick Khachatryan on 28.07.2024.
//

import UIKit

class HeaderOptionsTableViewCell: UITableViewHeaderFooterView {
  
    let headerLabel = UILabel(text: "", font: UIFont(name: "Avenir Next", size: 14), alignment: .left)
   
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerConfigure(nameArray: [String], section : Int) {
        headerLabel.text = nameArray[section]
    }
    
    func setConstraints() {
        
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
