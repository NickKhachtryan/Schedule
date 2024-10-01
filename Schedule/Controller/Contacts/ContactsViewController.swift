//
//  ContactsTableViewController.swift
//  Schedule
//
//  Created by Nick Khachatryan on 30.03.2024.
//

import UIKit
import RealmSwift

final class ContactsViewController : UIViewController {
    
    
    //MARK: - Private Properties
    
    private let idContactsCell = "idContactsCell"
    
    private let searchController = UISearchController()
    
    private let localmRealm = try! Realm()
    private var contactsArray : Results<ContactsModel>!
    private var filteredArray : Results<ContactsModel>!
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return true }
        return text.isEmpty
    }
    
    private var isFiltered: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Friends", "Teachers"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.900647819, green: 0.900647819, blue: 0.900647819, alpha: 1)
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    //MARK: - View Controller Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        contactsArray = localmRealm.objects(ContactsModel.self).filter("contactsType = 'Friend'")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.searchController = searchController
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        setConstraints()
        
    }
    
    
    //MARK: - Buttons
    
    @objc private func segmentChanged(){
        if segmentedControl.selectedSegmentIndex == 0 {
            contactsArray = localmRealm.objects(ContactsModel.self).filter("contactsType = 'Friend'")
            tableView.reloadData()
        } else {
            contactsArray = localmRealm.objects(ContactsModel.self).filter("contactsType = 'Teacher'")
            tableView.reloadData()
            
        }
    }
    
    @objc private func addButtonTapped() {
        let optionsVC = ContactsOptionsTableViewController()
        navigationController?.pushViewController(optionsVC, animated: true)
    }
    
    
    //MARK: - Private Methods
    
    private func editingModel(contactsModel: ContactsModel) {
        let optionsVC = ContactsOptionsTableViewController()
        optionsVC.contactsModel = contactsModel
        optionsVC.editModel = true
        optionsVC.cellNameArray = [
            contactsModel.contactsName,
            contactsModel.contactsPhoneNumber,
            contactsModel.contactsEmail,
            contactsModel.contactsType,
            ""
        ]
        optionsVC.imageIsChosen = true
        navigationController?.pushViewController(optionsVC, animated: true)
    }
}


//MARK: - Table View Methods

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltered ? filteredArray.count : contactsArray.count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        let model = (isFiltered ? filteredArray[indexPath.row] : contactsArray[indexPath.row])
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactsArray[indexPath.row]
        editingModel(contactsModel: model)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = contactsArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContactsModel(model: editingRow)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


//MARK: - UISearch Methods

extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredArray = contactsArray.filter("contactsName CONTAINS[c] %@", searchText)
        tableView.reloadData()
    }
    
}


//MARK: - Constraints

private extension ContactsViewController {
    func setConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView], axis: .vertical, spacing: 0, distribution: .equalSpacing)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
