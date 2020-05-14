//
//  MainCoordinator.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]();
    var navigationController: UINavigationController;
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController;
    }
    
    func start() {
        let vc = ViewController.instanciate();
        vc.coodinator = self;
        navigationController.pushViewController(vc, animated: true)
    }
    
    func changeOrCreateContact() {
        let vc = ContactCreateViewController.instanciate()
        vc.coordinator = self;
        navigationController.pushViewController(vc, animated: true)
    }
}
