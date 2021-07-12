//
//  CatCalVC.swift
//  Matthew-Dolan-CyberCatCal
//
//  Created by Matt Dolan External macOS on 2021-07-08.
//

import UIKit

class CatCalVC: UIViewController {
    
    // MARK: - Date Formatter
    let dateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.dateStyle = .full
        result.timeStyle = .none
        return result
    }()
    
    // MARK: - Global Variables
    var displayables = [CellDisplayable]()
    var dateArray = [String]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = .white

        tableView.register(CatCalTableViewCell.nib(), forCellReuseIdentifier: CatCalTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self

        configureCells()
    }
    
    // MARK: - Configure Cells
    func configureCells() {
        let calendar = Calendar(identifier: .iso8601)
        let startOfWeek = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        let days = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek)  }
        let today = calendar.startOfDay(for: Date())

        let dayDisplays = days.map { dateFormatter.string(from: $0) }
        dateArray = dayDisplays
        // Used for debug
        print(dateArray)
        
        displayables = days.map { date in
            CellDisplayable(
                backgroundColor: date == today ? .blue : .white,
                textColor: date == today ? .white : .black,
                currentDay: date == today
             )
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CatCalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CatCalTableViewCell.identifier, for: indexPath) as! CatCalTableViewCell
        
        let displayable = displayables[indexPath.row]
        cell.backgroundColor = displayable.backgroundColor
        cell.calendarLabel.textColor = displayable.textColor
        
        cell.calendarLabel?.text = dateArray[indexPath.row]
        
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CatCalVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
