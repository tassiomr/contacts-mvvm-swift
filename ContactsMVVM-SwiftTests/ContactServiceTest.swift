//
//  ContactServiceTest.swift
//  ContactsMVVM-SwiftTests
//
//  Created by Tássio Marcos Rocha on 17/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import XCTest
import RealmSwift
@testable import ContactsMVVM_Swift

class ContactServiceTest: XCTestCase {

    var service: ContactService!
    var realm: Realm!
    let contact: Contact = Contact(
        value:
        ["name": "Tássio Marcos",
         "email": "tassio@email.com",
         "phone": "+5531994731494"])
    
    let contactEmpty: Contact = Contact(
        value:
            ["name": "",
             "email": "",
             "phone": ""])
    let contactNil: Contact = Contact(
    value:
        ["name": nil,
         "email": nil,
         "phone": nil])
    
    override func setUp() {
        super.setUp()
        
        var config = Realm.Configuration();
        config.inMemoryIdentifier = self.name
        service = ContactService(config)
        self.seedDatabase()
    }
    
    func seedDatabase () {
        let contact2 = Contact(value: ["name": "Tássio Marcos",
        "email": "tassio@email.com",
        "phone": "+5531994731494"])
        let contact3 = Contact(value: ["name": "Tássio Marcos",
        "email": "tassio@email.com",
        "phone": "+5531994731494"])
        let contact4 = Contact(value: ["name": "Tássio Marcos",
        "email": "tassio@email.com",
        "phone": "+5531994731494"])
        
        let contacts: [Contact] = [contact, contact2, contact3, contact4];
        
        for contact in contacts {
            service.createUser(contact: contact, success: {
                return
            }) {
                return
            }
        }
        
    }
    
    // MARK - Testing Create User
    func testIftheSaveMethodWorks() {
        service.createUser(contact: contact, success: {
            return
        }) {
            return
        }
        
        guard let expectedUser: Contact = service.getAllUser().first else { return }
        XCTAssertEqual(contact, expectedUser)
        
    }
    
    func testIfTheSaveMethodCatchNullableInfo() {
        service.createUser(contact: contactNil, success: {
            return
        }) {
            return
        }
    
        let numberOfDb = service.getAllUser().count
        XCTAssertEqual(4, numberOfDb)
    }
    
    func testIfTheSaveMethodCatchEmptyInfo (){
        service.createUser(contact: contactEmpty, success: {
            return
        }) {
            return
        }
        
        let numberOfDb = service.getAllUser().count
        XCTAssertEqual(4, numberOfDb)
    }
    
    // Mark - Testing delete contact
    func testDeleteContactIsWork() {
        
        service.deleteUser(contact: contact, success: {
            return
        }) {
            return
        }
        
        let numberOfDb = service.getAllUser().count
        XCTAssertEqual(3, numberOfDb)
    }
}
