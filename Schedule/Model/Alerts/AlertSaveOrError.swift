//
//  AlertOK.swift
//  Schedule
//
//  Created by Nick Khachatryan on 26.08.2024.
//

import UIKit

extension UIViewController {
    
    func alertSaveOrError(title: String, message: String?) {
        
        let saveAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        
        saveAlert.addAction(ok)
        present(saveAlert, animated: true)
    }
}
