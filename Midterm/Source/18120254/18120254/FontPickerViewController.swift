//
//  FontPickerViewController.swift
//  18120254
//
//  Created by HUYTU on 11/20/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit


protocol fontPickerDelegate:class{
    func addFont(fontName: String)
}



class FontPickerViewController: UIViewController {

    // font array
    var pickerData = [String]()
    
    weak var delegate:fontPickerDelegate? = nil
    var fontPicked: String = ""

    // outlets
    @IBOutlet weak var fontPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFontName()
        fontPicker.delegate = self
        fontPicker.dataSource = self
    

    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButton(_ sender: Any) {
        delegate?.addFont(fontName: fontPicked)
        dismiss(animated: true, completion: nil)
    }
    
    func loadFontName(){
        for family in UIFont.familyNames{
            for names in UIFont.fontNames(forFamilyName: family){
                pickerData += [names]
            }
        }
    }
}


// font-picker protocol
extension FontPickerViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: pickerData[row], size: 28)
        label.text = pickerData[row]
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fontPicked = pickerData[row]
    }
    
}


