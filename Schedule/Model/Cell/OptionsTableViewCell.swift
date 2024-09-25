//
//  OptionsScheduleTableViewCell.swift
//  Schedule
//
//  Created by Nick Khachatryan on 20.06.2024.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameCellLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeatSwitch : UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isHidden = true
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    weak var switchRepeatDelegate: SwitchRepeatProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConstraints()
        self.backgroundColor = #colorLiteral(red: 0.900647819, green: 0.900647819, blue: 0.900647819, alpha: 1)
        
        repeatSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellScheduleConfigure(nameArray: [[String]] , indexPath: IndexPath, hexColor: String, switchRepeat: Bool) {
        
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
                
        let color = UIColor().colorFromHex(hexColor)
                
        backgroundViewCell.backgroundColor = (indexPath.section == 3 ? color.withAlphaComponent(1) : .white)
                
        repeatSwitch.isHidden = (indexPath.section == 4 ? false : true)
        repeatSwitch.onTintColor = color.withAlphaComponent(1)
        repeatSwitch.isOn = switchRepeat
    }
    
    func cellTasksConfigure(nameArray: [String] , indexPath: IndexPath, hexColor: String) {
        
        nameCellLabel.text = nameArray[indexPath.section]
        
        let color = UIColor().colorFromHex(hexColor)
        
        backgroundViewCell.backgroundColor = (indexPath.section == 3 ? color.withAlphaComponent(1) : .white )
    }
    
    func cellContactsConfigure(nameArray: [String] , indexPath : IndexPath, image : UIImage?) {
        
        nameCellLabel.text = nameArray[indexPath.section]
        
        if image == nil {
            indexPath.section == 4 ? backgroundViewCell.image = UIImage(systemName: "person.fill.badge.plus")?.withRenderingMode(.alwaysTemplate) : nil
        } else {
            indexPath.section == 4 ? backgroundViewCell.image = image : nil
            backgroundViewCell.contentMode = .scaleAspectFill
        }
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
          switchRepeatDelegate?.SwitchRepeatProtocol(value: paramTarget.isOn)
      }


    
    func setConstraints() {
        
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: topAnchor),
            backgroundViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
        ])
        
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15)
        ])
        
        self.contentView.addSubview(repeatSwitch)
        NSLayoutConstraint.activate([
            repeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            repeatSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -20)
        ])
        
    }
}
