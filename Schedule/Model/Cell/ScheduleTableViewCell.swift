//
//  ScheduleTableViewCell.swift
//  Schedule
//
//  Created by Nick Khachatryan on 01.04.2024.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
//    let lessonName: UILabel = {
//        let label = UILabel()
//        label.text = "Программирование"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//        return label
//    }()
//    let teacherName: UILabel = {
//        let label = UILabel()
//        label.text = "Петров Петр Петрович"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next", size: 20)
//        label.textAlignment = .right
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//        return label
//    }()
    
//    let lessonTime: UILabel = {
//        let label = UILabel()
//        label.text = "08:00"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next", size: 20)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//        return label
//    }()
    
//    let typeLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Тип:"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next", size: 14)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//        return label
//    }()
    
//    let lessonType: UILabel = {
//        let label = UILabel()
//        label.text = "Лекция"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//        return label
//    }()
    
//    let buildingLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Корпус:"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next", size: 14)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//        return label
//    }()
//    
//    let buildingNumber: UILabel = {
//        let label = UILabel()
//        label.text = "1"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//        return label
//    }()
//    
//    let audLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Аудитория:"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next", size: 14)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//        return label
//    }()
    
//    let lessonAud : UILabel = {
//        let label = UILabel()
//        label.text = "101"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//        return label
//    }()

    let lessonName = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 20), alignment: .left)
    let teacherName = UILabel(text: "", font:  UIFont(name: "Avenir Next", size: 20), alignment: .right )
    let lessonTime = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 20), alignment: .left)
    let typeLabel = UILabel(text: "Тип:", font: UIFont(name: "Avenir Next", size: 14), alignment: .right)
    let lessonType = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14), alignment: .left)
    let buildingLabel = UILabel(text: "Корпус:", font: UIFont(name: "Avenir Next", size: 14), alignment: .right)
    let buildingNumber = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14), alignment: .left)
    let audLabel = UILabel(text: "Аудитория:", font: UIFont(name: "Avenir Next", size: 14), alignment: .right)
    let lessonAud = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14), alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ScheduleModel){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        lessonName.text = model.scheduleName
        teacherName.text = model.scheduleTeacher
        guard let time = model.scheduleTime else { return }
        lessonTime.text = dateFormatter.string(from: time)
        lessonType.text = model.scheduleType
        buildingNumber.text = model.scheduleBuilding
        lessonAud.text = model.scheduleAudience
        
        backgroundColor = UIColor().colorFromHex("\(model.scheduleColor)").withAlphaComponent(1)
    }
    
    func setConstraints() {
        let topStackView = UIStackView(arrangedSubviews: [lessonName, teacherName], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(lessonTime)
        NSLayoutConstraint.activate([
            lessonTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            lessonTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            lessonTime.widthAnchor.constraint(equalToConstant: 100),
            lessonTime.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [typeLabel, lessonType, buildingLabel, buildingNumber, audLabel, lessonAud], axis: .horizontal, spacing: 5, distribution: .fillProportionally)
        
        self.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: lessonTime.trailingAnchor, constant: 5),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
    
    
    
}
