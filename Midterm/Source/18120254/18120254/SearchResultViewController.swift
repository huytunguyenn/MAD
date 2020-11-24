//
//  SearchResultViewController.swift
//  18120254
//
//  Created by HUYTU on 11/15/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit
import RealmSwift

class SearchResultViewController: UIViewController {

    var initialLetter = ""
    var recordsArr = [Record]()
    var filteredArr = [Record]()
    
    // outlets
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    
        // read data from DB
        let realm = try! Realm()
        let event = readEventFromDB(_realm: realm)
        recordsArr = Array(event.records)
        
        // title name
        titleName.text = "Please select your name"
        titleName.font = UIFont(name: event.font, size: CGFloat(event.fontSize))
        titleName.textColor = UIColor.UIColorFromString(string: event.fontColor)
        
     
        // querying for records
        for rc in recordsArr {
            if rc.name.hasPrefix("\(initialLetter)") == true || rc.name.hasPrefix("\(initialLetter.uppercased())") == true   {
                filteredArr += [rc]
            }
        }
  
       
    }
    
}

extension SearchResultViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
        cell.userFullName.text = filteredArr[indexPath.row].name
        if indexPath.row % 2 == 1 {
            cell.userFullName.textColor = UIColor(red: 0/255, green: 129/255, blue: 242/255, alpha: 1.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dest = storyboard?.instantiateViewController(identifier: "UserInfoViewController") as! UserInfoViewController
        dest.userFullName = filteredArr[indexPath.row].name
        dest.modalPresentationStyle = .fullScreen
        present(dest, animated: true, completion: nil)
        
    }
    
    
}



