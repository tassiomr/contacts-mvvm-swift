//
//  ContactDetailsViewController.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailsViewController : UIViewController, Storyboarded {
    var coordinator: MainCoordinator?
    var contact: Contact?
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var emailLabel: UILabel?
    @IBOutlet var phoneLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel?.text = contact?.name
        emailLabel?.text = contact?.email
        phoneLabel?.text = contact?.phone
    }
    
}
