//
//  Button.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 16/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation
import UIKit


class Button : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func setupUI () {
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .tomato
        tintColor = .white
    }
}
