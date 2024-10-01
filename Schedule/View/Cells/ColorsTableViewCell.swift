//
//  ColorScheduleTableViewCell.swift
//  Schedule
//
//  Created by Nick Khachatryan on 14.08.2024.
//

import UIKit

final class ColorsTableViewCell: UITableViewCell {
    
    
    //MARK: - Private Properties
    
    private let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: - Initialisators
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConstraints()
        self.backgroundColor = #colorLiteral(red: 0.900647819, green: 0.900647819, blue: 0.900647819, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Public Methods
    
    func cellConfigure(indexPath: IndexPath) {
        switch indexPath.section {
        case 0: backgroundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.2666666667, blue: 0.231372549, alpha: 1)
        case 1: backgroundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.5098039216, blue: 0.231372549, alpha: 1)
        case 2: backgroundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.9098039216, blue: 0.231372549, alpha: 1)
        case 3: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.737254902, blue: 0.3529411765, alpha: 1)
        case 4: backgroundViewCell.backgroundColor = #colorLiteral(red: 0, green: 0.7843137255, blue: 0.968627451, alpha: 1)
        case 5: backgroundViewCell.backgroundColor = #colorLiteral(red: 0, green: 0.5058823529, blue: 1, alpha: 1)
        case 6: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.4235294118, blue: 1, alpha: 1)
        default:
            print("ERROR IN ColorsTableViewCell")
        }
    }
    
    
    //MARK: - Constraints
    
    func setConstraints() {
        
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
    }
}
