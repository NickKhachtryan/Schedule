//
//  AlertForCellName.swift
//  Schedule
//
//  Created by Nick Khachatryan on 04.08.2024.
//

import UIKit

extension UIViewController {
    
    func alertForCellName(label : UILabel, name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok =  UIAlertAction(title: "OK", style: .default) { _ in 
            
            let tfAlert = alert.textFields?.first
            if tfAlert?.text == "" {
                
                let alert = UIAlertController(title: "Error", message: "Please fill in the line", preferredStyle: .alert)
                let ok =  UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: true)
                
            } else {
                
                guard let text = tfAlert?.text else {return}
                label.text = text
                completionHandler(text)
            }
        }
        
        alert.addTextField { tfAlert in
            tfAlert.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
        
    }
    
}

