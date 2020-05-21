//
//  Storyboard.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instanciate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instanciate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
