//
//  AdminViewController.swift
//  18120254
//
//  Created by HUYTU on 11/13/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit
import RealmSwift


class AdminViewController: UIViewController {
    
    let realm = try! Realm()
    var eventRead: Event = Event()
    
    override func viewDidLoad() {
        print(realm.configuration.fileURL!)
        super.viewDidLoad()
        eventRead = readEventFromDB(_realm: self.realm)
        //definesPresentationContext = true   // for exit to be full screen
    }
    
    
    
    
    // create new event
    @IBAction func goToCreate(_ sender: Any) {
        
        if checkNilDB(_realm: self.realm) == false {
            // alert delete current event before create new
            let alert = UIAlertController(title: "!", message: "Creating new event will delete all the info from the previous or current event in the app", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: { action -> Void in
                
                // delete in database
                deleteDB(_realm: self.realm)
                
                // go to create-view
                let dest = self.storyboard?.instantiateViewController(identifier: "CreateViewController")
                dest?.modalPresentationStyle = .fullScreen
                self.present(dest!, animated: true, completion: nil)
                
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action -> Void in
            })
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
        else {  // first time creating event
            // go to create-view
            let dest = self.storyboard?.instantiateViewController(identifier: "CreateViewController")
            dest?.modalPresentationStyle = .fullScreen
            self.present(dest!, animated: true, completion: nil)
        }
    }
    
    
    
    
    // edit current event
    @IBAction func gotoCreateWithData(_ sender: Any) {
        // alert if there's no data in DB before edit
        if checkNilDB(_realm: self.realm) == true {
            let alert = UIAlertController(title: "EVENT NOT FOUND!", message: "There is no current event. Please create one before edit", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { action -> Void in
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            // go to create-view
            let dest = self.storyboard?.instantiateViewController(identifier: "CreateViewController") as! CreateViewController
            dest.event = eventRead
            dest.modalPresentationStyle = .fullScreen
            self.present(dest, animated: true, completion: nil)
        }
    }
    
}









