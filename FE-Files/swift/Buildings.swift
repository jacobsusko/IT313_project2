//
//  Buildings.swift
//  jmustudyhall
//
//  Created by Holly and Teo.
//

import UIKit


class Buildings: UIViewController {
    
    let dataSource = ["Buildings", "Scheduling", "Notifications", "Settings"]
    
    let actionClosure = { (action: UIAction) in
        print(action.title)
    }
    
    let button = UIButton(primaryAction: nil)
    
    var menuChildren: [UIMenuElement] = []
    @IBOutlet weak var greetingLabel: UILabel! // Add this IBOutlet
    
    var isDropdownVisible = false
        let data = ["Buildings", "Scheduling", "Notifications", "Settings"]
        var firstName: String? // Add this variable to store user's first name
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Create the logout button dynamically
            let logoutButton = UIButton(type: .system)
            logoutButton.frame = CGRect(x: 30, y: 95, width: 150, height: 50)
            logoutButton.setTitle("Logout", for: .normal)
            logoutButton.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 19)
            logoutButton.setTitleColor(UIColor(red: 69/255, green: 0/255, blue: 132/255, alpha: 1), for: .normal)
            logoutButton.backgroundColor = UIColor(red: 223/255, green: 210/255, blue: 170/255, alpha: 1)
            logoutButton.layer.cornerRadius = 8
            logoutButton.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
            view.addSubview(logoutButton)
            
            for option in dataSource {
                // Customize the appearance of the menu items to match the buttons
                let action = UIAction(title: option, image: nil, identifier: nil) { _ in
                    self.navigateToViewController(option)
                }
                menuChildren.append(action)
            }
            
            button.menu = UIMenu(options: .displayInline, children: menuChildren)
            button.showsMenuAsPrimaryAction = true
            button.changesSelectionAsPrimaryAction = true
            
            // Set background color of the button
            button.backgroundColor = UIColor(red: 223/255, green: 210/255, blue: 170/255, alpha: 1)
            
            // Set button title and font
            button.setTitle("Buildings", for: .normal)
            button.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 19)
            
            // Set button title color
            button.setTitleColor(UIColor(red: 69/255, green: 0/255, blue: 132/255, alpha: 1), for: .normal)
            
            // Add corner radius to button
            button.layer.cornerRadius = 8
            
            // Add button tap action
            button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
            
            // Add button to the view
            button.frame = CGRect(x: 230, y: 95, width: 150, height: 50)
            view.addSubview(button)
            
            // Fetch user data
            fetchUserData()
            
            // Fetch button data
            fetchButtonData()
        }
        
        @objc func logoutButtonTapped(_ sender: UIButton) {
            // Remove all view controllers except the root view controller (login view controller)
            navigationController?.popToRootViewController(animated: false)
            
            // Navigate to the login page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginPage") as? Login {
                navigationController?.pushViewController(loginViewController, animated: true)
            }
        }
        
        func fetchUserData() {
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
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonObject = json as? [String: Any], let firstName = jsonObject["first_name"] as? String {
                        DispatchQueue.main.async {
                            self.greetingLabel.text = "Hello, \(firstName)"
                        }
                    } else {
                        print("Invalid JSON format or missing 'first_name' field")
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }.resume()
        }
        
        func fetchButtonData() {
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
                    if let jsonString = String(data: data, encoding: .utf8) {
                        let cleanedString = jsonString.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "'", with: "")
                        let buttonNames = cleanedString.components(separatedBy: ",")
                        
                        DispatchQueue.main.async {
                            self.createButtons(buttonNames)
                        }
                    } else {
                        print("Error converting data to string")
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }.resume()
        }
        
        func createButtons(_ buttonNames: [String]) {
            let startY = (view.frame.height - CGFloat(buttonNames.count * 60)) / 2
            
            for (index, name) in buttonNames.enumerated() {
                let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                
                let buttonElement = UIButton(type: .system)
                buttonElement.setTitle(trimmedName, for: .normal)
                buttonElement.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 19)
                buttonElement.setTitleColor(UIColor(red: 69/255, green: 0/255, blue: 132/255, alpha: 1), for: .normal)
                buttonElement.backgroundColor = UIColor(red: 223/255, green: 210/255, blue: 170/255, alpha: 1)
                buttonElement.layer.cornerRadius = 8
                buttonElement.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
                buttonElement.tag = index
                
                let buttonWidth: CGFloat = 200
                let startX = (view.frame.width - buttonWidth) / 2
                let buttonFrame = CGRect(x: startX, y: startY + CGFloat(index) * 60, width: buttonWidth, height: 40)
                
                buttonElement.frame = buttonFrame
                view.addSubview(buttonElement)
            }
        }
        
        @objc func buttonTapped(_ sender: UIButton) {
            guard let roomName = sender.currentTitle else {
                print("Button title is nil")
                return
            }
            
            guard let url = URL(string: "https://jmustudyhall.com/getRoomOccupancy?hall_name=\(roomName)") else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching room occupancy: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
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
        
        func navigateToViewController(_ option: String) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: UIViewController
            
            switch option {
            case "Buildings":
                viewController = storyboard.instantiateViewController(withIdentifier: "buildings") // Replace with actual identifier
            case "Scheduling":
                viewController = storyboard.instantiateViewController(withIdentifier: "Schedule") // Replace with actual identifier
            case "Notifications":
                viewController = storyboard.instantiateViewController(withIdentifier: "Notifications") // Replace with actual identifier
            case "Settings":
                viewController = storyboard.instantiateViewController(withIdentifier: "UserInfo") // Replace with
            default:
                return
            }
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

