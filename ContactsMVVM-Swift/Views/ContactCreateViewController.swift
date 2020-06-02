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
import RxSwift
import RxCocoa

class ContactCreateViewController : UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var viewModel: ContactCreateViewModel! {
        didSet {
            title = self.viewModel.contact?.name ?? "Adicionar Contato"
            self.nameTextField?.text = self.viewModel.contact?.name ?? ""
            self.phoneTextField?.text = self.viewModel.contact?.phone ?? ""
            self.emailTextField?.text = self.viewModel.contact?.email ?? ""
            
            if self.viewModel.contact == nil {
                self.button?.setTitle("Adicionar", for: .normal)
            } else {
                self.button?.setTitle("Atualizar", for: .normal)
            }
        }
    }
    var contact: Contact?
    
    @IBOutlet var nameTextField: UITextField?
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var phoneTextField: UITextField?
    @IBOutlet var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ContactCreateViewModel(
                            service: ContactService(),
                            contact: self.contact)
        self.setupBinding()
    }
    
    @IBAction func addNewContact (_sender: Any) {
        self.viewModel.createOrUpdateUser()
        navigationController?.popViewController(animated: true)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        title = textField.text
    }
    
    @objc func changeInpuValues(_ textField: UITextField) {

        if self.viewModel.nameText.value.isEmpty  {
            title = "Adicionar Contato"
        } else {
            title = self.viewModel.nameText.value
        }
    }
    
    
    func setupBinding() {
       _ = emailTextField?
            .rx
            .text
            .map { $0 ?? "" }
            .bind(to: viewModel.emailText)
        _ = phoneTextField?
            .rx
            .text
            .map { $0 ?? "" }
            .bind(to: viewModel.phoneText)
        _ = nameTextField?
            .rx
            .text
            .map { $0 ?? "" }
            .bind(to: viewModel.nameText)
        
       _ = viewModel.isValid.bind(to: (button?.rx.isEnabled)!)
        viewModel.isValid.subscribe(onNext: {
            isValid in
            self.title = isValid ? "Enabled" : self.title
        }).disposed(by: DisposeBag())
    }
}

extension String {
    func toCVarArg() -> CVarArg {
        return self as CVarArg
    }
}
