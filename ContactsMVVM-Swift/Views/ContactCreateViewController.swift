//
//  ContactChangesViewController.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift


class ContactCreateViewController : UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var viewModel: ContactCreateViewModel!
    var contact: Contact?
    
    @IBOutlet var nameTextField: UITextField?
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var phoneTextField: UITextField?
    @IBOutlet var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ContactCreateViewModel(service: ContactService(), contact: self.contact)
        self.setupTextFieldValues()
        self.setupBinding()
    }
    
    func removeButton() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        if let viewWithTag =  navigationBar.viewWithTag(200) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    @IBAction func addNewContact (_sender: Any) {
        self.viewModel.createOrUpdateUser()
        navigationController?.popViewController(animated: true)
    }
}

extension ContactCreateViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        title = textField.text
    }
    
    @objc func changeInpuValues(_ textField: UITextField) {
        self.viewModel.name = self.nameTextField?.text ?? ""
        self.viewModel.email = self.emailTextField?.text ?? ""
        self.viewModel.phone = self.phoneTextField?.text ?? ""
    }
    
    func setupTextFieldValues() {
        self.nameTextField?.text = self.viewModel.contact?.name ?? ""
        self.phoneTextField?.text = self.viewModel.contact?.phone ?? ""
        self.emailTextField?.text = self.viewModel.contact?.email ?? ""
    }
    
    func setupBinding() {
        self.emailTextField?.addTarget(self, action: #selector(changeInpuValues(_:)), for: .editingChanged)
        self.phoneTextField?.addTarget(self, action: #selector(changeInpuValues(_:)), for: .editingChanged)
        self.nameTextField?.addTarget(self, action: #selector(changeInpuValues(_:)), for: .editingChanged)
    }
}

extension String {
    func toCVarArg() -> CVarArg {
        return self as CVarArg
    }
}
