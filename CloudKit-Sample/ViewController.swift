//
//  ViewController.swift
//  CloudKit-Sample
//
//  Created by Francis Jemuel Bergonia on 1/15/20.
//  Copyright © 2020 Arkray PHM. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                print(error)
            } else if let recordID = recordID {
                print(recordID)
            }
        }
    }


}

