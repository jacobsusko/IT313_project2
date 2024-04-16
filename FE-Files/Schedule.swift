//
//  Schedule.swift
//  jmustudyhall
//
//  Created by Teo.
//
import UIKit

class Schedule: UIViewController {

    let dataSource = ["Buildings", "Scheduling", "Notifications", "Settings"]
    
    let actionClosure = { (action: UIAction) in
        print(action.title)
    }
    
    let button = UIButton(primaryAction: nil)
    
    var menuChildren: [UIMenuElement] = []
    
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
        
        // Add button to the view
        button.frame = CGRect(x: 230, y: 95, width: 150, height: 50)
        view.addSubview(button)
        
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
