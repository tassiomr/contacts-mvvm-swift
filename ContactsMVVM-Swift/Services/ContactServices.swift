//
//  ContactServices.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation

import Realm
import RealmSwift


class ContactService  {
    var realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func createUser(contact: Contact) {
        try! realm.write {
            realm.add(contact)
        }
    }
    
    func updateUser(contact: Contact) {
        let predicate = NSPredicate(format: "id = %@", contact.id.toCVarArg())
       let updateContact = realm.objects(Contact.self).filter(predicate).first
       try! realm.write {
            updateContact?.name = contact.name
            updateContact?.email = contact.email
            updateContact?.phone = contact.phone
       }
    }
    
    func deleteUser(contact: Contact) {
        try! realm.write {
            realm.delete(contact)
        }
    }
    
    func getAllUser(contact: Contact) -> Results<Contact> {
       let contacts = realm.objects(Contact.self)
        
        return contacts;
    }
}
