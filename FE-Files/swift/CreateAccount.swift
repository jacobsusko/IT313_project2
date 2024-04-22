//
//  CreateAccount.swift
//  jmustudyhall
//
//  Created by Holly & Teo.
//

import UIKit

class CreateAccount: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
    
        
        guard let fname = firstNameTextField.text, let lname = lastNameTextField.text,let email = emailTextField.text, let username = usernameTextField.text, let password = passwordTextField.text else {
                // Handle invalid input
                return
            }
            
            // Create the URL for your server's login endpoint
            guard let url = URL(string: "https://jmustudyhall.com/signup") else {
                let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
                print("Error: \(error)")
                return
            }
            
            // Prepare the request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Create a dictionary with the username and password
        let parameters: [String: Any] = ["username": username, "password": password, "email": email, "fname": fname, "lname": lname]
            
            // Convert the parameters to JSON data
            guard let requestData = try? JSONSerialization.data(withJSONObject: parameters) else {
                let error = NSError(domain: "Serialization Error", code: 0, userInfo: nil)
                print("Error: \(error)")
                return
            }
            
            request.httpBody = requestData
            
            // Create a URLSession task to perform the request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // Handle the response
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                
                // Print the HTTP response status code and headers
                // Check the status code for successful login (typically 200)
                if httpResponse.statusCode == 401 {
                    print("Username or Email already in use.")
                    // Handle login failure on the main thread
                    DispatchQueue.main.async {
                        // Show an alert for failed login
                        let alert = UIAlertController(title: "Failed to Create Account", message: "Username or Email already in use.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    return // Exit the function without navigating to the login page
                }

                if (200..<300).contains(httpResponse.statusCode) {
                    print("Account creation successful")
                    DispatchQueue.main.async {
                        // Display success alert
                        let alert = UIAlertController(title: "Account Successfully Created.", message: "You can now log in.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            // Navigate to the login page
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginPage") as? Login {
                                self.navigationController?.pushViewController(loginViewController, animated: true)
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    // Perform any further actions upon successful account creation
                } else {
                    // Handle account creation failure based on the status code
                    let errorDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    print("Account creation failed with error:", errorDescription)
                    // Handle account creation failure
                }
            }
            
            // Start the task
            task.resume()
    }
    
    
}
