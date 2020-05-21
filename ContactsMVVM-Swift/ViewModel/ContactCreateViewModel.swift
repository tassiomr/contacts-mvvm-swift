//
//  ContactViewModel.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation

class ContactCreateViewModel {
    var contact: Contact?
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var service: ContactService
    
    init(service: ContactService, contact: Contact?) {
        self.contact = contact
        self.service = service
    }
    
    private func initVariables() {
        if self.contact != nil {
            guard let extractedContact = self.contact else { return }
            
            self.name = extractedContact.name
            self.email = extractedContact.email
            self.phone = extractedContact.phone
        }
    }
    
    func createOrUpdateUser() {
        if contact == nil {
            self.contact = Contact(value: ["name": self.name, "email": self.email, "phone": self.phone])
            self.service.createUser(contact: self.contact!, success: {
                //success
                return
            }) {
                // error
                return
            }
        } else {
            guard let contact = self.contact else { return }            
            self.service.updateUser(id: contact.id, name: self.name, email: self.email
                , phone: self.phone, success: {
                //success
                return
            }, error: {
                // error
                return
            })
            
        }
        
    }
}
