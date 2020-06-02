//
//  ContactViewModel.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class ContactCreateViewModel {
    var contact: Contact?
    var nameText: BehaviorRelay<String>;
    var emailText: BehaviorRelay<String>;
    var phoneText: BehaviorRelay<String>;

    var service: ContactService
    
    init(service: ContactService, contact: Contact?) {
        self.contact = contact
        self.service = service

        nameText = BehaviorRelay<String>(value: contact?.name ?? "")
        emailText = BehaviorRelay<String>(value: contact?.email ?? "")
        phoneText = BehaviorRelay<String>(value: contact?.phone ?? "")
    }
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(nameText.asObservable(), emailText.asObservable(), phoneText.asObservable()) { name, email, phone in
            
            return (name.count >= 3 && email.count >= 3) || (name.count >= 3 && phone.count == 11)
            
        }
    }
    
    

    func createOrUpdateUser() {
        if contact == nil {
            self.contact = Contact(value: ["name": self.nameText.value, "email": self.emailText.value, "phone": self.phoneText.value])
            self.service.createUser(contact: self.contact!, success: {
                //success
                return
            }) {
                // error
                return
            }
        } else {
            guard let contact = self.contact else { return }
            self.service.updateUser(contact: contact, success: {
                return
            }) {
                return
            }
        }
        
    }
}
