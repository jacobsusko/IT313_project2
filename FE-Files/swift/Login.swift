//
//  Login.swift
//  jmustudyhall
//
//  Created by Holly & Teo.
//

import UIKit
import Foundation

class Login: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
                // Handle invalid input
                return
            }
            
            // Create the URL for your server's login endpoint
            guard let url = URL(string: "https://jmustudyhall.com/login") else {
                let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
                print("Error: \(error)")
                return
            }
            
            // Prepare the request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Create a dictionary with the username and password
            let parameters: [String: Any] = ["username": username, "password": password]
            
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
                    print("Username or Password is Incorrect.")
                    // Handle login failure on the main thread
                    DispatchQueue.main.async {
                        // Show an alert for failed login
                        let alert = UIAlertController(title: "Failed to Login", message: "Username or password is incorrect. Please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                
                if (200..<300).contains(httpResponse.statusCode) {
                    print("Login successful")
                    
                    // Navigate to the Buildings view controller on the main thread
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let buildingsViewController = storyboard.instantiateViewController(withIdentifier: "buildings") as? Buildings {
                            self.navigationController?.pushViewController(buildingsViewController, animated: true)
                        }
                    }
                    // Perform any further actions upon successful login
                } else {
                    // Handle login failure based on the status code
                    let errorDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    print("Login failed with error:", errorDescription)
                    // Handle login failure
                }
            }
            
            // Start the task
            task.resume()
    }
}
    
   
