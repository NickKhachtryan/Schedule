//
//  AlertOK.swift
//  Schedule
//
//  Created by Nick Khachatryan on 26.08.2024.
//

import UIKit

extension UIViewController {
    
    func saveAlert(title: String) {
        
        let saveAlert = UIAlertController(title: title, message: "Info succesfully saved", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        
        saveAlert.addAction(ok)
        present(saveAlert, animated: true)
    }
}
