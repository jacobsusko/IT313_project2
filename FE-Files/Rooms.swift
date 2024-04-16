//
//  Buildings.swift
//  jmustudyhall
//
//  Created by Holly and Teo.
//
import UIKit

class Rooms: UIViewController {
    
    var roomOccupancyData: [[String: Any]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Call the method to fetch data
    }

    func updateRoomOccupancyData(with json: Any) {
        if let jsonData = json as? [[String: Any]] {
            self.roomOccupancyData = jsonData
            DispatchQueue.main.async {
                self.createButtons()
            }
        }
    }
    
    func createButtons() {
        guard let roomData = roomOccupancyData else {
            return
        }
        
        // Remove existing buttons if any
        for subview in view.subviews {
            if let button = subview as? UIButton {
                button.removeFromSuperview()
            }
        }
        
        let buttonWidth: CGFloat = 260 // Adjusted width
        let buttonHeight: CGFloat = 60 // Adjusted height
        let bigGap: CGFloat = 20 // Adjusted bigger gap
        let smallGap: CGFloat = 20 // Adjusted smaller gap
        let yOffset = (view.frame.height - CGFloat(roomData.count * 2) * (buttonHeight + smallGap) - bigGap) / 2 + 80 // Adjusted vertical offset
        
        for (index, data) in roomData.enumerated() {
            let hallName = data["hall_name"] as? String ?? "Unknown Hall"
            let roomNumber = data["room_num"] as? Int ?? 0
            let isOccupied = data["occupied"] as? Int ?? 0
            
            // Create main room button
            let roomButton = UIButton(type: .system)
            roomButton.frame = CGRect(x: (view.frame.width - buttonWidth) / 2, y: yOffset + CGFloat(index * 2) * (buttonHeight + smallGap + bigGap), width: buttonWidth, height: buttonHeight)
            let trimmedName = "\(hallName) \(roomNumber) is \(isOccupied == 1 ? "Occupied" : "Vacant")"
            roomButton.setTitle(trimmedName, for: .normal)
            roomButton.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 19)
            roomButton.setTitleColor(UIColor(red: 69/255, green: 0/255, blue: 132/255, alpha: 1), for: .normal)
            roomButton.backgroundColor = UIColor(red: 223/255, green: 210/255, blue: 170/255, alpha: 1)
            roomButton.layer.cornerRadius = 8
            roomButton.addTarget(self, action: #selector(roomButtonTapped(_:)), for: .touchUpInside)
            roomButton.tag = index
            view.addSubview(roomButton)
            
            // Create report button
            let reportButton = UIButton(type: .system)
            reportButton.frame = CGRect(x: (view.frame.width - buttonWidth) / 2, y: yOffset + CGFloat(index * 2 + 1) * (buttonHeight + smallGap + bigGap) - bigGap, width: buttonWidth, height: buttonHeight)
            reportButton.setTitle("Report room", for: .normal)
            reportButton.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 19)
            reportButton.setTitleColor(UIColor.white, for: .normal)
            reportButton.backgroundColor = UIColor(red: 128/255, green: 0/255, blue: 128/255, alpha: 1)
            reportButton.layer.cornerRadius = 8
            reportButton.addTarget(self, action: #selector(reportButtonTapped(_:)), for: .touchUpInside)
            reportButton.tag = index
            view.addSubview(reportButton)
        }
    }
    
    @objc func reportButtonTapped(_ sender: UIButton) {
        print("Report button tapped") // Add this line to print a message
        
        guard let roomData = roomOccupancyData else { return }
        let room = roomData[sender.tag] // Get room data for the tapped button
        
        let hallName = room["hall_name"] as? String ?? ""
        let roomNumber = room["room_num"] as? Int ?? 0
        
        guard let url = URL(string: "https://jmustudyhall.com/updateFlag") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Construct JSON payload
        let parameters: [String: Any] = [
            "hallName": hallName, // Matching with server-side parameter names
            "roomNum": roomNumber // Matching with server-side parameter names
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error encoding parameters: \(error)")
            return
        }
        
        // Set the content type to JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Show alert immediately
        let alert = UIAlertController(title: "Success", message: "Room reported successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle network response if needed
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Handle JSON response if needed
                    print(json)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }



}
