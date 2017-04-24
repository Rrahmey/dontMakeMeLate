//
//  GetStartedViewController.swift
//  Dont-make-me-late
//
//  Created by Raquel Rahmey on 4/24/17.
//  Copyright © 2017 Raquel Rahmey. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {
    
    var age: Double = 0
    var height: Double = 0
    var weight: Double = 0
    var gender: Gender = .female

    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var HeightButton: UIButton!
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var genderSC: UISegmentedControl!
    @IBOutlet weak var agePicker: UIDatePicker!
    @IBOutlet weak var bodyMesPicker: UIPickerView!
    @IBOutlet weak var enterPickerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agePicker.isHidden = true
        bodyMesPicker.isHidden = true
        enterPickerButton.isHidden = true
    }

    @IBAction func ageButtonPressed(_ sender: Any) {
        agePicker.isHidden = false
        enterPickerButton.isHidden = false
    }
    
    @IBAction func enterButtonPressed(_ sender: Any) {
       let birthday = agePicker.date
        let today = NSDate()
        let ageComponents = NSCalendar.current.dateComponents(DateComponents.init(), from: birthday, to: today as Date)
        var age = ageComponents
    }
    
    


}
