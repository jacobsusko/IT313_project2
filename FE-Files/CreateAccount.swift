//
//  CreateAccount.swift
//  jmustudyhall
//
//  Created by Holly Mpassy on 28/03/2024.
//

import UIKit

class CreateAccount: UIViewController {
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        let username = "centralteam"
        let password = "C3n7r@1^73@NN"
        let firstName = ""
        let lastName = ""
        let email = ""
        
        createAccount(firstName: firstName, lastName: lastName, username: username, password: password, email: email) { error in
            if let error = error {
                print("Error creating account: \(error.localizedDescription)")
            } else {
                print("Account created successfully")
                DispatchQueue.main.async {
                    // Show an alert indicating successful account creation
                    let alertController = UIAlertController(title: "Success", message: "Account created successfully", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                        // Navigate back to the login view controller
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
