//
//  SavePhoto.swift
//  CloudKit-Sample
//
//  Created by Francis Jemuel Bergonia on 1/28/20.
//  Copyright © 2020 Arkray PHM. All rights reserved.
//

import Foundation
import RealmSwift

class SavePhoto: Object {
    @objc dynamic var key = ""
    @objc dynamic var photoData: NSData? = nil
    
    override static func primaryKey() -> String? {
        return "key"
    }
    
    convenience init(key: String, photoData: NSData?) {
        self.init()
        self.key = key
        self.photoData = photoData
    }
}
