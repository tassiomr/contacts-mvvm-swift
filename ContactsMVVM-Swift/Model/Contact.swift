//
//  Contacts.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation
import RealmSwift


class Contact : Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String!
    @objc dynamic var email: String!
    @objc dynamic var phone: String!
    
 
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
