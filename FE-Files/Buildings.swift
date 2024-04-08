//
//  Buildings.swift
//  jmustudyhall
//
//  Created by Holly Mpassy on 28/03/2024.
//

import UIKit


class Buildings: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var dropdownButton: UIButton!
        @IBOutlet weak var pickerView: UIPickerView!
        @IBOutlet weak var greetingLabel: UILabel! // Add this IBOutlet
            
        var isDropdownVisible = false
        let data = ["Scheduling", "Notifications", "Settings"]
        var firstName: String? // Add this variable to store user's first name
            
        override func viewDidLoad() {
            super.viewDidLoad()
                
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.isHidden = true
                
            // Check if firstName is not nil, then update the greeting label
            if let firstName = firstName {
                greetingLabel.text = "Hello, \(firstName)"
            }
        }
            
        // MARK: - UIPickerViewDataSource Methods
            
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
            
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return data.count
        }
            
        // MARK: - UIPickerViewDelegate Methods
            
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return data[row]
        }
            
        // MARK: - IBActions
            
        @IBAction func dropdownButtonTapped(_ sender: UIButton) {
            isDropdownVisible.toggle()
            pickerView.isHidden = !isDropdownVisible
        }
    
}
