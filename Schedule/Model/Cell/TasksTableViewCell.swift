//
//  TasksTableViewCell.swift
//  Schedule
//
//  Created by Nick Khachatryan on 09.05.2024.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    let taskName = UILabel(text: "Программирование", font: UIFont(name: "Avenir Next Demi Bold", size: 20), alignment: .left)
    let taskDescription = UILabel(text: "Бла бла бла бла Бла бла бла бла Бла бла бла бла Бла бла бла бла Бла", font: UIFont(name: "Avenir Next", size: 14), alignment: .left)
    
    var readyButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var cellTaskDelegate: PressReadyTaskButtonProtocol?
    var index: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        taskDescription.numberOfLines = 2
        setConstraints()
        
        readyButton.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func readyButtonTapped(){
        guard let index = index else {return}
        cellTaskDelegate?.readyButtonTapped(indexPath: index)
    }
    
    func setConstraints() {
        
        self.contentView.addSubview(readyButton)
        NSLayoutConstraint.activate([
            readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalToConstant: 30),
            readyButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        self.addSubview(taskName)
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: self.topAnchor),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            taskName.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        self.addSubview(taskDescription)
        NSLayoutConstraint.activate([
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor),
            taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            taskDescription.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
    }

}

