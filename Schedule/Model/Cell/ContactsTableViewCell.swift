//
//  ContactsTableViewCell.swift
//  Schedule
//
//  Created by Nick Khachatryan on 15.08.2024.
//

import UIKit

final class ContactsTableViewCell: UITableViewCell {
    
    
    //MARK: - Private Properties
    
    private let contactImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .red
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let phoneImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let mailImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "envelope.fill")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel = UILabel(text: "Nick Khachatryan", font: UIFont(name: "Avenir Next", size: 30), alignment: .left)
    private let phoneLabel = UILabel(text: "+374 77 940409", font: UIFont(name: "Avenir Next", size: 14), alignment: .left)
    private let mailLabel = UILabel(text: "nickoarm@gmail.com", font: UIFont(name: "Avenir Next", size: 14), alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Public Methods
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
    }
    
    func configure(model : ContactsModel){
        nameLabel.text = model.contactsName
        phoneLabel.text = model.contactsPhoneNumber
        mailLabel.text = model.contactsEmail
        
        if let data = model.contactsImage, let image = UIImage(data: data) {
            contactImageView.image = image
        } else {
            contactImageView.image = UIImage(systemName: "person.circle")
        }
    }
    
    
    //MARK: - Constraints
    
    func setConstraints() {
        
        self.addSubview(contactImageView)
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            contactImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            contactImageView.heightAnchor.constraint(equalToConstant: 70),
            contactImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel, mailImageView, mailLabel], axis: .horizontal, spacing: 3, distribution: .fillProportionally)
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
    }
}


