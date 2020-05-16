//
//  ViewController.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import RxSwift

class MainViewController: UIViewController, Storyboarded,UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: MainViewModel! {
        didSet {
            self.contacts = viewModel.contacts
        }
    }
    weak var coodinator: MainCoordinator?
    var contactService: ContactService = ContactService();
    @IBOutlet weak var tableView: UITableView!
    var contacts = [Contact]()
    var realm: Realm?
    
    private let button: UIButton = UIButton(type: .contactAdd)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = MainViewModel(service: self.contactService);
        
        self.setupUI()

        do {
            self.realm = try Realm()
        } catch let error as NSError {
            print(error)
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        self.setupUI()
    }

    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshContacts))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToCreateContact))
    }
    
    // Table View Functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:            IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell");
        cell.textLabel?.text = self.contacts[indexPath.row].name;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") {(action, view, nil) in
            tableView.setEditing(false, animated: true)
            self.updateContact(index: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        edit.backgroundColor = .link
        let delete = UIContextualAction(style: .destructive, title: "Delete") {(action, view, nil) in
            self.viewModel.deleteContact(self.contacts[indexPath.row]) {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        delete.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coodinator?.contactDetail(contact: self.contacts[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    // Others functions
    func deleteContact(index: Int) {
        let contact: Contact = self.contacts[index]
        self.viewModel.deleteContact(contact) {
            tableView.reloadData()
        }
    }

    func updateContact(index: Int) {
        coodinator?.changeOrCreateContact(contact: self.contacts[index])
    }
    
    @objc func goToCreateContact() {
        print("entrei")
        coodinator?.changeOrCreateContact(contact: nil);
    }
    
    @objc func refreshContacts() {
        self.viewModel.getContacts()
        self.tableView.reloadData()
    }
}

