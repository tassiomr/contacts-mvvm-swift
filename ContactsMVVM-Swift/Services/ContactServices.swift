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
    
    init(_ realmConfig: Realm.Configuration) {
        realm = try! Realm(configuration: realmConfig)
    }
    
    func createUser(contact: Contact, success: () -> Void, error: () -> Void) {
        let isValidContact = self.isAValidContact(contact: contact)
        
        if isValidContact {
            try! realm.write {
                realm.add(contact)
                success()
                return
            }
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

extension ContactService {
    private func validateIfExistValueNil(contact: Contact) -> Bool {
        if contact.email == nil || contact.name == nil || contact.phone == nil {
            return false
        }
        return true
    }
    
    private func validadeIfExistValueEmpty(contact: Contact) -> Bool {
        if contact.email.isEmpty || contact.name.isEmpty || contact.phone.isEmpty {
            return false
        }
        return true
    }
    
    private func isAValidContact(contact: Contact) -> Bool {
        return validateIfExistValueNil(contact: contact) && validadeIfExistValueEmpty(contact: contact)
    }
}
