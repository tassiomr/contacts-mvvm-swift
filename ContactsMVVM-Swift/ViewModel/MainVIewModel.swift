//
//  MainVIewModel.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation
import RxSwift

protocol MainProtocol {
    func getContact()
    func deleteContact(completion: (Contact) -> Void)
    func updateContact(completion: (Contact) -> Void)
}

enum Actions {
    case createUpdate
    case delete
}

class MainViewModel {
    
    var contacts: [Contact] = [Contact]()
    var service: ContactService
    
    init(service: ContactService) {
        self.service = service;
        self.getContacts()
    }
    
    func getContacts() {
        let results = self.service.getAllUser()
        
        for contact in results {
            self.contacts.append(contact)
        }
    }
    
    func deleteContact(_ contact: Contact, success: () -> Void) {
        self.service.deleteUser(contact: contact, success: {
            success()
        }) {
            return
        }
    }
        
    private func reloadList(action: Actions, contact: Contact?) {
        self.getContacts()
    }
    
}
