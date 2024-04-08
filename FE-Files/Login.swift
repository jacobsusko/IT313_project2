//
//  Login.swift
//  jmustudyhall
//
//  Created by Holly Mpassy on 28/03/2024.
//

import UIKit

class Login: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    let loginManager = LoginManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            // Handle invalid input
            return
        }

        loginManager.performLogin(username: username, password: password, viewController: self) { success in
            DispatchQueue.main.async {
                if success {
                    print("Login successful")
                    // Navigate to the Buildings view controller
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let buildingsViewController = storyboard.instantiateViewController(withIdentifier: "buildings") as? Buildings {
                        self.navigationController?.pushViewController(buildingsViewController, animated: true)
                    }
                } else {
                    print("Login failed")
                    // Show an alert for failed login
                                let alert = UIAlertController(title: "Failed to Login", message: "Invalid username or password. Please try again.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
