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

class ViewController: UIViewController, Storyboarded,UITableViewDelegate, UITableViewDataSource {
    
    weak var coodinator: MainCoordinator?
    @IBOutlet weak var tableView: UITableView!
    var button: UIButton?
    var contacts = [Contact]()
    var realm: Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getContacts()

        do {
            self.realm = try Realm()
        } catch let error  as NSError {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:            IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell");
        cell.textLabel?.text = self.contacts[indexPath.row].name;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func getContacts () {
        let realm = try! Realm()
        let contacts = realm.objects(Contact.self)
        
        for contact in contacts {
            print(contact)
            self.contacts.append(contact)
        }
        self.tableView.reloadData();
    }
}

