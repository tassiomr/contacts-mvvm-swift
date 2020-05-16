//
//  Label.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 16/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Foundation
import UIKit

class Label : UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func setupUI () {
        textColor = .gray
        font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
