//
//  Contacts.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation


struct Contact {
    var id: UUID!
    var name: String!
    var email: String!
    var phone: String!
    
    init(name: String, email: String, phone: String) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.phone = phone
    }
}
