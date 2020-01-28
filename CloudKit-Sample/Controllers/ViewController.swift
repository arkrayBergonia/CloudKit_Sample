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

    @IBOutlet weak var textfield: UITextField!
    
    
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

    @IBAction func saveBtnTapped(_ sender: UIButton) {
        print("saveBtnTapped")
    }
    
    @IBAction func retrieveBtnTapped(_ sender: UIButton) {
        print("retrieveBtnTapped")
    }
    
    @IBAction func updateBtnTapped(_ sender: UIButton) {
        print("updateBtnTapped")
    }
    
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        print("deleteBtnTapped")
    }
}

