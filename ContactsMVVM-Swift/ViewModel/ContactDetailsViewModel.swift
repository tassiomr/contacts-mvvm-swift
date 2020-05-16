//
//  ContactDetailsViewModel.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation

struct ContactDetailsViewModel {
    private var contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    var name: String {
        return contact.name
    }
    
    var email: String {
        return contact.email
    }
    
    var phone: String {
        return contact.phone
    }
    
    
}
