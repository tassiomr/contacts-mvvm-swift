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
    
    override func setUp() {
        super.setUp()
        
        var config = Realm.Configuration();
        config.inMemoryIdentifier = self.name
        service = ContactService(config)
    }
    
    // MARK - Testing Create User
    func testIftheSaveMethodWorks() {
        service.createUser(contact: contact, success: {
            return
        }) {
            return
        }
        
        guard let expectedUser = self.realm.objects(Contact.self).first else { return }
        XCTAssertEqual(contact, expectedUser)
        
    }
    
    func testIfTheSaveMethodCatchNullableInfo() {
        // MARK - When Name is nil
        contact.name = nil
    
        service.createUser(contact: contact, success: {
            return
        }) {
            return
        }
    
        let numberOfDb = service.getAllUser().count
        XCTAssertEqual(0, numberOfDb)
    }
    
    func testIfTheSaveMethodCatchEmptyInfo (){
        contact.name = ""
        
        service.createUser(contact: contact, success: {
            return
        }) {
            return
        }
        
        let numberOfDb = service.getAllUser().count
        XCTAssertEqual(0, numberOfDb)
    }
    

}
