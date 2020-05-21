//
//  RealmConfig.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 16/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import Realm
import RealmSwift


struct RealConfigurations {
    var config = Realm.Configuration()

    
   static func instantiate () {
        // Override point for customization after application launch.
        var config = Realm.Configuration();
        config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("ContactMVVM-Swift.realm");
        
        Realm.Configuration.defaultConfiguration = config;
    }
}
