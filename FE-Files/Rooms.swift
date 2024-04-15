//
//  Buildings.swift
//  jmustudyhall
//
//  Created by Holly and Teo.
//
import UIKit

class Rooms: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var roomOccupancyData: [[String: Any]]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    func updateRoomOccupancyData(with json: Any) {
        if let jsonData = json as? [[String: Any]] {
            self.roomOccupancyData = jsonData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table View Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomOccupancyData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Get the room data for the current index
        if let roomData = roomOccupancyData?[indexPath.row] {
            // Extract hall name, room number, and occupied status
            let hallName = roomData["hall_name"] as? String ?? "Unknown Hall"
            let roomNumber = roomData["room_num"] as? Int ?? 0
            let isOccupied = roomData["occupied"] as? Int ?? 0

            // Customize cell's text based on room data
            cell.textLabel?.text = "\(hallName) \(roomNumber) is \(isOccupied == 1 ? "Occupied" : "Vacant")"
        } else {
            // If room data is not available, show default text
            cell.textLabel?.text = "No data available"
        }

        return cell
    }

    // MARK: - Table View Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row \(indexPath.row + 1)")
    }
}
