//
//  ContactsTableViewController.swift
//  Schedule
//
//  Created by Nick Khachatryan on 30.03.2024.
//

import UIKit

class ContactsTableViewController : UITableViewController {
    
    private let idContactsCell = "idContactsCell"
    
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        title = "Contacts"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.900647819, green: 0.900647819, blue: 0.900647819, alpha: 1)
        tableView.separatorStyle = .singleLine
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))

    }
    
    @objc private func addButtonTapped() {
        let optionsVC = ContactsOptionsTableViewController()
        navigationController?.pushViewController(optionsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TAP")
    }
}
