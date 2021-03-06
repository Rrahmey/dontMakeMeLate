//
//  GetStartedViewController.swift
//  Dont-make-me-late
//
//  Created by Raquel Rahmey on 4/24/17.
//  Copyright © 2017 Raquel Rahmey. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var age = Int() {
        didSet {
            ageBool = true
            canGoToNext()
        }
    }
    var feet: Int = 0
    var inch: Int = 0
    var height = Int() {
        didSet {
            heightBool = true
            canGoToNext()
        }
    }
    var weight = Int() {
        didSet{
            weightBool = true
            canGoToNext()
        }
    }
    var gender: Gender = .female
    var pickerDataSource = [[String]]()
    var ageBool = false
    var heightBool = false
    var weightBool = false
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var HeightButton: UIButton!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var genderSC: UISegmentedControl!
    @IBOutlet weak var agePicker: UIDatePicker!
    @IBOutlet weak var enterPickerButton: UIButton!
    @IBOutlet weak var enterHeightButton: UIButton!
    @IBOutlet weak var heightPicker: UIPickerView!
    @IBOutlet weak var nextPageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = true
        
        setUpDatePicker()
        enterPickerButton.isHidden = true
        heightPicker.isHidden = true
        enterHeightButton.isHidden = true
        weightTextField.delegate = self
        nextPageButton.isHidden = true
        backgroundImage.alpha = 0.7
    }
    
    func setUpDatePicker() {
        agePicker.isHidden = true
        agePicker.datePickerMode = UIDatePickerMode.date
        agePicker.maximumDate = Date()
        let dateString = "Jan 1 2000"
        let df = DateFormatter()
        df.dateFormat = "MM dd yyyy"
        let date = df.date(from: dateString)
        if let unwrappedDate = date {
            agePicker.setDate(unwrappedDate, animated: false)
        }
    }
    
    @IBAction func ageButtonPressed(_ sender: Any) {
        heightPicker.isHidden = true
        enterHeightButton.isHidden = true
        agePicker.isHidden = false
        enterPickerButton.isHidden = false
        agePicker.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        weightTextField.endEditing(true)
    }
    
    @IBAction func enterButtonPressed(_ sender: Any) {
        enterPickerButton.isHidden = true
        currentAge()
    }
    
    @IBAction func heightButtonPressed(_ sender: Any) {
        agePicker.isHidden = true
        enterPickerButton.isHidden = true
        setUpHeightPicker()
        enterHeightButton.isHidden = false
        weightTextField.endEditing(true)
    }
    
    
    func currentAge() {
        let dob = agePicker.date
        let today = Date()
        let calendar = Calendar(identifier: .gregorian)
        let agediff = calendar.dateComponents([.month, .day, .year], from: dob, to: today)
        guard let personAge = agediff.year else {print("could not get age"); return}
        
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            if personAge == 0 {
                self.ageButton.setTitle("Please enter a valid age", for: .normal)
                self.ageButton.setTitleColor(UIColor.red, for: .normal)
            } else if personAge < 10 {
                self.ageButton.setTitle("Must be at least 10", for: .normal)
                self.ageButton.setTitleColor(UIColor.red, for: .normal)
                
            } else {
                self.ageButton.setTitle(String(personAge), for: .normal)
                self.age = personAge
                self.enterPickerButton.isHidden = true
            }
        }, completion: nil)
    }
    
    @IBAction func enterHeightButtonPressed(_ sender: Any) {
        enterHeightButton.isHidden = true
        height = (feet * 12) + inch
        HeightButton.setTitle("\(feet)' \(inch)\"", for: .normal)
        heightPicker.isHidden = true
    }
    
    
    
    func setUpHeightPicker() {
        heightPicker.isHidden = false
        heightPicker.delegate = self
        heightPicker.dataSource = self
        var feetArray = [String]()
        var inchArray = [String]()
        for i in 0...9 {
            let foot = "\(i)'"
            feetArray.append(foot)
        }
        for i in 0...12 {
            let inch = "\(i)" + "\""
            inchArray.append(inch)
        }
        pickerDataSource = [feetArray,inchArray]
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let foot = pickerDataSource[component][row]
            let feetShort = foot.substring(to: foot.index(before: foot.endIndex))
            feet = Int(feetShort)!
            
        } else if component == 1 {
            let inches = pickerDataSource[component][row]
            let inchShort = inches.substring(to: inches.index(before: inches.endIndex))
            inch = Int(inchShort)!
        }
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if weightTextField.text == "" {
            weightTextField.text = "Weight"
            return
        } else if weightTextField.text != "Weight"{
            guard let weightText = weightTextField.text else {return}
            weightTextField.text = weightText + " lbs"
            weight = Int(weightText)!
        }
        self.view.endEditing(true)
        self.agePicker.isHidden = true
        self.heightPicker.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        enterPickerButton.isHidden = true
        enterHeightButton.isHidden = true
        agePicker.isHidden = true
        heightPicker.isHidden = true
        weightTextField.text = ""
        weightTextField.keyboardType = UIKeyboardType.numberPad
        
    }
    
    func canGoToNext() {
        if ageBool == true && heightBool == true && weightBool == true {
            print("just entered here")
            nextPageButton.isHidden = false 
            UIView.animate(withDuration: 2.0, delay: 1.0, options: [.autoreverse, .curveEaseIn], animations: {
                self.nextPageButton.isHidden = false
                                
            }, completion: nil )
        } else {
            print("not yet")
        }
    }
    
    @IBAction func getStartedButtonPressed(_ sender: Any) {
        if genderSC.selectedSegmentIndex == 0 {
            print(genderSC.selectedSegmentIndex)
            gender = .female
        } else if genderSC.selectedSegmentIndex == 1 {
            print(genderSC.selectedSegmentIndex)
            gender = .male
        }
     
    }
    
}
