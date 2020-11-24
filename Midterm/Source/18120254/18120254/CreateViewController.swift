//
//  CreateViewController.swift
//  18120254
//
//  Created by HUYTU on 11/13/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit
import IGColorPicker
import RealmSwift



class CreateViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var fontButton: UIButton!
    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet var fontColorPickerView: ColorPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    // UIColor string represent
    var colorString: String = "[0.0, 0.0, 0.0, 1.0]" // default is black
    // event loaded from DB (from admin VC)
    var event = Event()
    // records list (load from event)
    var recordList = [Record]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // font size
        fontSizeSlider.addTarget(self, action: #selector(fontSizeSliderDidChange(slider:)), for: .valueChanged)
        fontSizeSliderDidChange(slider: fontSizeSlider)
        
        // color-picker
        view.addSubview(fontColorPickerView)
        fontColorPickerView.delegate = self
        
        // LOAD DATA FROM DB (FOR EDIT MODE)
        // load event name from DB
        eventName.text = event.name
        eventName.isEnabled = true
        
        // load font name from DB
        fontLabel.text = event.font
        fontLabel.font = UIFont(name: event.font, size: 17)
        colorString = event.fontColor
        fontLabel.textColor = UIColor.UIColorFromString(string: colorString)
        
        // load font size from DB
        fontSizeLabel.text = "\(event.fontSize)"
        fontSizeSlider.value = Float(event.fontSize)
        
        // load records from event (event load from DB)
        recordList = Array(event.records)
        
    }
    
    // pop up pickerview to choose font
    @IBAction func pickerFontDidChange(_ sender: Any) {
        let dest = storyboard?.instantiateViewController(identifier: "FontPickerViewController") as! FontPickerViewController
        dest.delegate = self
        self.present(dest, animated: true, completion: nil)
    }
    
    // slide the font size
    @objc func fontSizeSliderDidChange(slider:UISlider){
        let currentFontSize = Int(slider.value)
        fontSizeLabel.text = "\(currentFontSize)"
    }
    
    // go to add-guest VC
    @IBAction func addRecord(_ sender: Any) {
        let dest = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        dest.delegate = self
        self.present(dest, animated: true, completion: nil)
        
    }
    
    
    // save event info to DB
    @IBAction func saveToDatabase(_ sender: Any) {
        
        if eventName.text == "" || fontLabel.text == ""  { // if entered empty string
            // show alert
            let alert = UIAlertController(title: "!", message: "Please complete all the information", preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .cancel, handler: { action -> Void in
            })
            alert.addAction(retryAction)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            // add new data
            let realm = try! Realm()
            let addEvent = makeEvent(_name: eventName.text!, _font: fontLabel.text!, _fontsize: Int(fontSizeLabel.text!)!, _fontColor: colorString, _records: recordList)
            addEventToDB(_realm: realm, _event: addEvent)
            // popup message shows that added successfully
            let alert = UIAlertController(title: "EVENT ADDED", message: "Save event successfully", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { action -> Void in
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}

// color-picker protocol ----------------------------------------------------------------
extension CreateViewController: ColorPickerViewDelegate {
    // a color has been selected
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        fontLabel.textColor = colorPickerView.colors[indexPath.item]
        colorString = UIColor.StringFromUIColor(color: fontLabel.textColor)
        
    }
    
}


// table-view protocol ----------------------------------------------------------------
extension CreateViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.name.text = recordList[indexPath.row].name
        cell.guests.text = recordList[indexPath.row].guests
        cell.table.text = recordList[indexPath.row].table
        cell.section.text = recordList[indexPath.row].section
        return cell
    }
    
    
}

// DELEGATE ADOPT & IMPLEMENT ----------------------------------------------------------------

// for add-guest VC
extension CreateViewController : addGuestDelegate{
    func addARecord(guest: Record) {
        let rc = makeRecord(_name: guest.name, _guests: guest.guests, _table: guest.table, _section: guest.section)
        recordList += [rc]
        tableView.reloadData()
    }
    
}

// for font-picker VC
extension CreateViewController : fontPickerDelegate{
    func addFont(fontName: String) {
        fontLabel.font = UIFont(name: fontName, size: 17)
        fontLabel.text = fontName
    }
}

// ------------------------------------------------------------------------------

// UIColor converter function
public extension UIColor {
    
    // uicolor to string
    class func StringFromUIColor(color: UIColor) -> String {
        let components = color.cgColor.components
        if (color.cgColor.numberOfComponents < 4) {
            return "[0.0, 0.0, 0.0, 1.0]"
        }
        else {
            return "[\(components![0]), \(components![1]), \(components![2]), \(components![3])]"
        }
    }
    
    // string to uicolor
    class func UIColorFromString(string: String) -> UIColor {
        var componentsString = string.replacingOccurrences(of: "[", with: "")
        componentsString = componentsString.replacingOccurrences(of: "]", with: "")
        
        let components = componentsString.components(separatedBy: ", ")
        return UIColor(red: CGFloat((components[0] as NSString).floatValue),
                       green: CGFloat((components[1] as NSString).floatValue),
                       blue: CGFloat((components[2] as NSString).floatValue),
                       alpha: CGFloat((components[3] as NSString).floatValue))
    }
    
}
