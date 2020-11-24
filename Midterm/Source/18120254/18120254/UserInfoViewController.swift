//
//  UserInfoViewController.swift
//  18120254
//
//  Created by HUYTU on 11/15/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit
import RealmSwift

class UserInfoViewController: UIViewController {
    
    var userFullName = ""
    var recordsArr = [Record]()
    var inMyTableArr = [Record]()
    
    // outlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var tableNumber: UIButton!
    @IBOutlet weak var guestsNumber: UIButton!
    @IBOutlet weak var sectionNumber: UIButton!
    @IBOutlet weak var whoseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whoseTableView.delegate = self
        whoseTableView.dataSource = self
        
        // set no action for button
        tableNumber.isUserInteractionEnabled = false
        guestsNumber.isUserInteractionEnabled = false
        sectionNumber.isUserInteractionEnabled = false
        
        // load data from DB
        let realm = try! Realm()
        let event = readEventFromDB(_realm: realm)
        recordsArr = Array(event.records)
        
        // titles' label
        userNameLabel.text = userFullName
        userNameLabel.textColor = UIColor(red: 0/255, green: 129/255, blue: 242/255, alpha: 1.0)
        tableNumberLabel.font = UIFont(name: event.font, size: 32.0)
        tableNumberLabel.textColor = UIColor.UIColorFromString(string: event.fontColor)
        guestsLabel.font = UIFont(name: event.font, size: 32.0)
        guestsLabel.textColor = UIColor.UIColorFromString(string: event.fontColor)
        sectionLabel.font = UIFont(name: event.font, size: 32.0)
        sectionLabel.textColor = UIColor.UIColorFromString(string: event.fontColor)
        
        var myTable = ""
        // buttons' label
        for rc in recordsArr {
            if rc.name == userFullName  {
                myTable = rc.table
                tableNumber.setTitle("\(rc.table)", for: .normal)
                guestsNumber.setTitle("\(rc.guests)", for: .normal)
                sectionNumber.setTitle("\(rc.section)", for: .normal)
            }
        }
        
        // whose in my table?
        for rc in recordsArr{
            if rc.table == myTable && rc.name != userFullName {
                inMyTableArr += [rc]
            }
        }
    
    }

    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        inMyTableArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = whoseTableView.dequeueReusableCell(withIdentifier: "WhoseTableViewCell") as! WhoseTableViewCell
        cell.guestNameLabel.text = inMyTableArr[indexPath.row].name
        cell.guestsLabel.text = inMyTableArr[indexPath.row].guests
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor(red: 200/255, green: 231/255, blue: 247/255, alpha: 1.0)
        }
        else {
            cell.contentView.backgroundColor = UIColor(red: 229/255, green: 246/255, blue: 252/255, alpha: 1.0)
        }
        return cell
    }
    
    
    
}
