//
//  UserViewController.swift
//  18120254
//
//  Created by HUYTU on 11/15/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit
import RealmSwift

class UserViewController: UIViewController {

    @IBOutlet weak var eventName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let event = readEventFromDB(_realm: realm)
        eventName.text = event.name
        eventName.font = UIFont(name: event.font, size: CGFloat(event.fontSize))
        eventName.textColor = UIColor.UIColorFromString(string: event.fontColor)

      
    }

}
