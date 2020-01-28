//
//  SaveItem.swift
//  CloudKit-Sample
//
//  Created by Francis Jemuel Bergonia on 1/28/20.
//  Copyright © 2020 Arkray PHM. All rights reserved.
//

import Foundation
import RealmSwift

class SaveItem: Object {
    @objc dynamic var key = ""
    @objc dynamic var value = ""
    
    override static func primaryKey() -> String? {
        return "key"
    }
    
    convenience init(key: String, value: String) {
        self.init()
        self.key = key
        self.value = value
    }
}
