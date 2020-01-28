//
//  ImportExportDataManager.swift
//  EmergencyCall_Swift
//
//  Created by Francis Jemuel Bergonia on 1/16/20.
//  Copyright © 2020 Arkray PHM. All rights reserved.
//

import Foundation
import UIKit

class ImportExportDataManager {
    
    // local variable used for Backup **Data-related WIP
    let directoryName = "Preferences"
    let plistName = "jp.co.arkray.EmergencyCall_Swift.plist"
    let allPasswordKeys = ["test-Data", "test-Photo"]
    
    var allNotePhotoKeys : [String] {
        let notePhotoKeys = ["test-Photo"]
        return notePhotoKeys
    }
    
    var strPlistPath : String {
        let strLibraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        return "\(strLibraryPath)/\(self.directoryName)/\(self.plistName)"
    }
    var localURL : URL {
        return URL(fileURLWithPath: self.strPlistPath)
    }
    
    // plistChecker for her AlertBox **Data-related WIP
    func checkPlistAlreadyExist() -> Bool {
        return !FileManager.default.fileExists(atPath: self.strPlistPath)
    }
    
    private func savePropertyList(_ plist: Any) throws {
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try plistData.write(to: localURL)
    }
    
    
    private func loadPropertyList() throws -> [String:Any] {
        let data = try Data(contentsOf: localURL)
        guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any] else {
            return [:]
        }
        return plist
    }
    
    private func loadRealmData() -> [String:Any] {
        let allKeys = self.allPasswordKeys
        let photoKeys = self.allNotePhotoKeys
        var realmDictionary = [String:Any]()
        
        for key in allKeys {
            if let savedItem = RealmDatabaseManager.fetch(key: key) {
                realmDictionary[key] = savedItem.value
            }
        }
        
        for key in photoKeys {
            if let savedPhoto = RealmDatabaseManager.fetchPhoto(key: key) {
                if let photoData = savedPhoto.photoData {
                    let photoEncoded = photoData.base64EncodedString(options: [])
                    realmDictionary[key] = photoEncoded
                    //print("loadRealmData key:\(key) && photoData:\(photoEncoded)")
                }
            }
        }
        
        print("loadRealmData ****** \(realmDictionary) ******")
        return realmDictionary
    }
    
    func exportRealmToPlist() {
        let realmData = loadRealmData()
        
        if !realmData.isEmpty {
            do {
                print("exportRealmToPlist: savePropertyList called")
                try savePropertyList(realmData)
            } catch {
                print("exportRealmToPlist error: \(error)")
            }
        } else {
            print("exportRealmToPlist: realmData is Empty")
        }
    }
    
    func importPlistToRealm() {
        let allKeys = self.allPasswordKeys
        let photoKeys = self.allNotePhotoKeys
        
        do {
            let pListData = try loadPropertyList()
            print("importPlistToRealm readPlist: \(pListData)")
            
            for key in allKeys {
                if let value = pListData[key] {
                    let importItem = SaveItem()
                    importItem.key = key
                    importItem.value = value as! String
                    RealmDatabaseManager.save(importItem)
                    //print("importPlistToRealm importItem key:\(key) && value:\(value)")
                }
            }
            
            for key in photoKeys {
                if let value = pListData[key] {
                    let url = URL(string: String(format:"data:application/octet-stream;base64,%@",value as! CVarArg))
                    let importPhoto = SavePhoto()
                    importPhoto.key = key
                    importPhoto.photoData = NSData(contentsOf: url!)
                    RealmDatabaseManager.save(importPhoto)
                    //print("importPlistToRealm importPhoto key:\(key) && value:\(value)")
                }
            }
            
        } catch {
            print("importPlistToRealm error: \(error)")
        }
    }
}

