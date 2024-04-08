//
//  Buildings.swift
//  jmustudyhall
//
//  Created by Holly and Teo.
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

            guard let url = URL(string: "https://jmustudyhall.com/userData") else {
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching user data: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {
                    print("test")
                    // Assuming your response is a JSON object with a "name" field
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonObject = json as? [String: Any], let firstName = jsonObject["first_name"] as? String {
                        // Update the greeting label on the main thread
                        DispatchQueue.main.async {
                            self.greetingLabel.text = "Hello, \(firstName)"
                        }
                    } else {
                        print("Invalid JSON format or missing 'name' field")
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }.resume()

            guard let hallsURL = URL(string: "https://jmustudyhall.com/halls") else {
                return
            }

            URLSession.shared.dataTask(with: hallsURL) { data, response, error in
                if let error = error {
                    print("Error fetching button data: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {
                        // Convert data to string
                        if let jsonString = String(data: data, encoding: .utf8) {
                            // Remove square brackets and single quotes from the JSON string
                            let cleanedString = jsonString.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "'", with: "")

                            // Split the cleaned string by commas to get individual button names
                            let buttonNames = cleanedString.components(separatedBy: ",")

                            // Calculate total height of buttons
                            let totalButtonHeight = buttonNames.count * 60 // Assuming each button is 60 units in height

                            // Calculate y-coordinate for the first button to start in the center vertically
                            let startY = (self.view.frame.height - CGFloat(totalButtonHeight)) / 2

                            // Loop through each button name
                            for (index, name) in buttonNames.enumerated() {
                                // Trim leading and trailing whitespace and quotes from the button name
                                let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: CharacterSet(charactersIn: "\""))

                                // Create button-like element
                                let buttonElement = UIButton(type: .system)
                                buttonElement.setTitle(trimmedName, for: .normal)
                                buttonElement.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 19)
                                buttonElement.setTitleColor(UIColor(red: 69/255, green: 0/255, blue: 132/255, alpha: 1), for: .normal) // Set font color
                                buttonElement.backgroundColor = UIColor(red: 223/255, green: 210/255, blue: 170/255, alpha: 1) // Set background color
                                buttonElement.layer.cornerRadius = 8 // Round corners for button-like appearance
                                buttonElement.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
                                buttonElement.tag = index

                                // Position the button horizontally at the center of the screen
                                let buttonWidth: CGFloat = 200 // Assuming the button width is 200 units
                                let startX = (self.view.frame.width - buttonWidth) / 2
                                let buttonFrame = CGRect(x: startX, y: startY + CGFloat(index) * 60, width: buttonWidth, height: 40)

                                // Add the button to your view on the main thread
                                DispatchQueue.main.async {
                                    self.view.addSubview(buttonElement)
                                    // Set the button's frame
                                    buttonElement.frame = buttonFrame
                                }
                            }
                        } else {
                            print("Error converting data to string")
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
                }.resume()
        }

    @objc func buttonTapped(_ sender: UIButton) {
        guard let roomName = sender.currentTitle else {
            print("Button title is nil")
            return
        }
        
        print("Button tapped with title: \(roomName)")
        
        // Make a GET request to the getRoomOccupancy route
        guard let url = URL(string: "https://jmustudyhall.com/getRoomOccupancy?hall_name=\(roomName)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching room occupancy: \(error)")
                // Handle the error, such as showing an alert to the user
                return
            }
            
            guard let data = data else {
                print("No data received")
                // Handle the case where no data is received
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let roomsViewController = storyboard.instantiateViewController(withIdentifier: "rooms") as? Rooms {
                        roomsViewController.updateRoomOccupancyData(with: json)
                        self.navigationController?.pushViewController(roomsViewController, animated: true)
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }.resume()
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
