//
//  ContactServices.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation

import Realm
import RxSwift
import RealmSwift


class ContactService  {
    var realm: Realm
    var contacts: [Contact] = [Contact]()
    
    init() {
        realm = try! Realm()
    }
    
    func createUser(contact: Contact, success: () -> Void, error: () -> Void) {
        try! realm.write {
            realm.add(contact)
            success()
            return
        }
        
        error()
    }
    
    func updateUser(id: String, name: String?, email: String?, phone: String?, success: () -> Void, error: () -> Void) {
        let predicate = NSPredicate(format: "id = %@", id.toCVarArg())
        let updateContact = realm.objects(Contact.self).filter(predicate).first
        
        try! realm.write {
            updateContact?.name = name
            updateContact?.email = email
            updateContact?.phone = phone
            success()
            return
        }
        
        error()
    }
    
    func deleteUser(contact: Contact, success: () -> Void, error: () -> Void) {
        try! realm.write {
            realm.delete(contact)
            success()
            return
        }
        
        error()
    }
    
    func getAllUser() -> Results<Contact> {
                return  self.realm.objects(Contact.self)
    }
}
