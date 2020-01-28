//
//  RealmDatabaseManager.swift
//  EmergencyCall_Swift
//
//  Created by Francis Jemuel Bergonia on 1/6/20.
//  Copyright © 2020 Arkray PHM. All rights reserved.
//


import Foundation
import RealmSwift

class RealmDatabaseManager {
    static let realm = try! Realm()
    
    
    static func getAllNotePhotos() -> Results<SavePhoto>? {
        var photos: Results<SavePhoto>?
        photos = realm.objects(SavePhoto.self)
        let sortedPhotos = photos?.sorted(byKeyPath: "key", ascending: true)
        return sortedPhotos
    }
    
    static func save(_ object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error Saving Object: \(error.localizedDescription)")
        }
    }
    
    static func update(_ object: Object) {
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print("Error Saving Object: \(error.localizedDescription)")
        }
    }
    
    static func delete(_ object: Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error Deleting Object: \(error.localizedDescription)")
        }
    }
    
    static func fetch(key: String) -> SaveItem? {
        
        if let fetchResult = realm.objects(SaveItem.self).filter("key = '\(key)'" ).first {
            return SaveItem(key: fetchResult.key, value: fetchResult.value)
        }
        print("Realm Object not found //user haven't saved data")
        return nil
    }
    
    static func fetchPhoto(key: String) -> SavePhoto? {
        
        if let fetchResult = realm.objects(SavePhoto.self).filter("key = '\(key)'" ).first {
            return SavePhoto(key: fetchResult.key, photoData: fetchResult.photoData)
        }
        print("Realm Image Object not found //user haven't saved photo")
        return nil
    }
}



