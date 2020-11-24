//
//  ViewController.swift
//  18120254
//
//  Created by HUYTU on 11/13/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var adminButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      
   
    }

    @IBAction func gotoUser(_ sender: Any) {
        let realm = try! Realm()
        if checkNilDB(_realm: realm) == true {
            let alert = UIAlertController(title: "EVENT NOT FOUND!", message: "There is no available event for user", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { action -> Void in
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            // go to user-view
            let dest = self.storyboard?.instantiateViewController(identifier: "UserViewController") as! UserViewController
            dest.modalPresentationStyle = .fullScreen
            self.present(dest, animated: true, completion: nil)
            
        }
    }
    
}

