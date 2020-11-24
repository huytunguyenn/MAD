//
//  AddViewController.swift
//  18120254
//
//  Created by HUYTU on 11/14/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit

protocol addGuestDelegate :class{
    func addARecord(guest: Record)
}

class AddViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var guests: UITextField!
    @IBOutlet weak var table: UITextField!
    @IBOutlet weak var section: UITextField!
    
    
    
    
    // delegate property
    weak var delegate: addGuestDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    // back to create-view
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // add guest info & go back to create-view
    @IBAction func addGuest(_ sender: Any) {
        // if entered empty string
        if firstName.text == "" || lastName.text == "" || guests.text == "" || table.text == "" || section.text == "" {
            let alert = UIAlertController(title: "!", message: "Please complete all the information", preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .cancel, handler: { action -> Void in
            })
            alert.addAction(retryAction)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let num = Int(guests.text!)
            // if guest is not a number
            if num != nil {
                let fullName: String = firstName.text! + ", " + lastName.text!
                let guest = makeRecord(_name: fullName, _guests: guests.text!, _table: table.text!, _section: section.text!)
                delegate?.addARecord(guest: guest)
                dismiss(animated: true, completion: nil)
             
               
            }
            else {
                let alert = UIAlertController(title: "YOUR GUEST IS NOT A NUMBER!", message: "Please enter a number", preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .cancel, handler: { action -> Void in
                })
                alert.addAction(retryAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    

}
