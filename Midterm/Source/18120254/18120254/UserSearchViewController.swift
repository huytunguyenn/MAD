//
//  UserSearchViewController.swift
//  18120254
//
//  Created by HUYTU on 11/15/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit
import RealmSwift

class UserSearchViewController: UIViewController {

    @IBOutlet weak var titleName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let event = readEventFromDB(_realm: realm)
        titleName.text = "Please select your last name initial"
        titleName.font = UIFont(name: event.font, size: CGFloat(event.fontSize))
        titleName.textColor = UIColor.UIColorFromString(string: event.fontColor)
    }
    
    func gotoResult(string: String){
        let dest = storyboard?.instantiateViewController(identifier: "SearchResultViewController") as! SearchResultViewController
        dest.initialLetter = string
        dest.modalPresentationStyle = .fullScreen
        self.present(dest, animated: true, completion: nil)
        
    }
    
    @IBAction func searchInitial_A(_ sender: Any) {
        gotoResult(string: "a")
    }
    
    @IBAction func searchInitial_B(_ sender: Any) {
        gotoResult(string: "b")
    }
    
    @IBAction func searchInitial_C(_ sender: Any) {
        gotoResult(string: "c")
    }
    
    @IBAction func searchInitial_D(_ sender: Any) {
        gotoResult(string: "d")
    }
    
    @IBAction func searchInitial_E(_ sender: Any) {
        gotoResult(string: "e")
    }
    
    @IBAction func searchInitial_F(_ sender: Any) {
        gotoResult(string: "f")
    }
    
    @IBAction func searchInitial_G(_ sender: Any) {
        gotoResult(string: "g")
    }
    
    @IBAction func searchInitial_H(_ sender: Any) {
        gotoResult(string: "h")
    }
    
    @IBAction func searchInitial_I(_ sender: Any) {
        gotoResult(string: "i")
    }
    
    
    @IBAction func searchInitial_J(_ sender: Any) {
        gotoResult(string: "j")
    }
    
    @IBAction func searchInitial_K(_ sender: Any) {
        gotoResult(string: "k")
    }
    
    @IBAction func searchInitial_L(_ sender: Any) {
        gotoResult(string: "l")
    }
    
    @IBAction func searchInitial_M(_ sender: Any) {
        gotoResult(string: "m")
    }
    
    @IBAction func searchInitial_N(_ sender: Any) {
        gotoResult(string: "n")
    }
    
    @IBAction func searchInitial_O(_ sender: Any) {
        gotoResult(string: "o")
    }
    
    @IBAction func searchInitial_P(_ sender: Any) {
        gotoResult(string: "p")
    }
    
    @IBAction func searchInitial_Q(_ sender: Any) {
        gotoResult(string: "q")
    }
    
    @IBAction func searchInitial_R(_ sender: Any) {
        gotoResult(string: "r")
    }
    
    @IBAction func searchInitial_S(_ sender: Any) {
        gotoResult(string: "s")
    }
    
    @IBAction func searchInitial_T(_ sender: Any) {
        gotoResult(string: "t")
    }
    
    @IBAction func searchInitial_U(_ sender: Any) {
        gotoResult(string: "u")
    }
    
    @IBAction func searchInitial_V(_ sender: Any) {
        gotoResult(string: "v")
    }
    
    @IBAction func searchInitial_W(_ sender: Any) {
        gotoResult(string: "w")
    }
    
    @IBAction func searchInitial_X(_ sender: Any) {
        gotoResult(string: "x")
    }
    
    @IBAction func searchInitial_Y(_ sender: Any) {
        gotoResult(string: "y")
    }
    
    
    @IBAction func searchInitial_Z(_ sender: Any) {
        gotoResult(string: "z")
    }
    
    
}



