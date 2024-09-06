//
//  UILabel.swift
//  Schedule
//
//  Created by Nick Khachatryan on 08.05.2024.
//

import UIKit
extension UILabel {
    convenience init(text: String, font: UIFont?, alignment: NSTextAlignment) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = .black
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.backgroundColor = .red
    }
}
