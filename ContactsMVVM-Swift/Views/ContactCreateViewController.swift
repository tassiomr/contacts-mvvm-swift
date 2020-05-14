//
//  ContactChangesViewController.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift


class ContactCreateViewController : UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var realm: Realm?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.realm = try! Realm()
        self.removeButton()
        
        
    }
    
    func removeButton() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        if let viewWithTag =  navigationBar.viewWithTag(200) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    @IBAction func addNewContact () {
        let realm = try! Realm()
        try! realm.write {
            let contact = Contact();
            contact.email = "tassiomr@gmail.com"
            contact.name = "Vanda"
            contact.phone = "+5531994731494"
            
            realm.add(contact)
        }
    }
}
