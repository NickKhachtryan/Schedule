//
//  TasksTableViewCell.swift
//  Schedule
//
//  Created by Nick Khachatryan on 09.05.2024.
//

import UIKit

final class TasksTableViewCell: UITableViewCell {
    
    //MARK: - Private Properties
    
    private let taskName = UILabel(text: "Программирование", font: UIFont(name: "Avenir Next Demi Bold", size: 20), alignment: .left)
    private let taskDescription = UILabel(text: "Бла бла бла бла Бла бла бла бла Бла бла бла бла Бла бла бла бла Бла", font: UIFont(name: "Avenir Next", size: 14), alignment: .left)
    
    private var readyButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Public Properties
    
    weak var cellTaskDelegate: PressReadyTaskButtonProtocol?
    var index: IndexPath?
    
    
    //MARK: - Initialisation
    
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
    
    
    //MARK: - Buttons
    
    @objc func readyButtonTapped(){
        guard let index = index else { return }
        print("tap")
        cellTaskDelegate?.readyButtonTapped(indexPath: index)
    }
    
    
    //MARK: - Public Methods
    
    func configure(model: TaskModel){
        taskName.text = model.taskName
        taskDescription.text = model.taskDescription
        
        backgroundColor = UIColor().colorFromHex(model.taskColor).withAlphaComponent(1)
        
        if model.taskReady {
            readyButton.setBackgroundImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            readyButton.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    
    
    //MARK: - Constraints
    
    private func setConstraints() {
        
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

