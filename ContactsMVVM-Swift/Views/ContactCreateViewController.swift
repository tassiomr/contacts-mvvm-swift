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
    var contact: Contact?
    
    @IBOutlet var nameTextField: UITextField?
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var phoneTextField: UITextField?
    @IBOutlet var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.realm = try! Realm()
        self.removeButton()
        
        title = "Adicionar contato"
        nameTextField?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        if self.contact != nil {
            title = contact?.name
            nameTextField?.text = contact?.name
            emailTextField?.text = contact?.email
            phoneTextField?.text = contact?.phone
            button?.setTitle("Atualizar", for: .normal)
        }
    }
    
    func removeButton() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        if let viewWithTag =  navigationBar.viewWithTag(200) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    @IBAction func addNewContact (_sender: Any) {
        let realm = try! Realm()
        
        if self.contact == nil {
            try! realm.write {
                self.contact = Contact();
                contact?.email = self.emailTextField?.text
                contact?.name = self.nameTextField?.text
                contact?.phone = self.phoneTextField?.text
                
                realm.add(contact!)
            }
        } else {
            let predicate = NSPredicate(format: "id = %@", contact!.id.toCVarArg()) 
            let updateContact = realm.objects(Contact.self).filter(predicate).first
            
            try! realm.write {
                updateContact?.name = self.nameTextField?.text
                updateContact?.email = self.emailTextField?.text
                updateContact?.phone = self.phoneTextField?.text
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension ContactCreateViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        title = textField.text
    }
}

extension String {
    func toString () -> String {
        return String(self)
    }
    
    func toCVarArg() -> CVarArg {
        return self as CVarArg
    }
}
