//
//  CatCalVC.swift
//  Matthew-Dolan-CyberCatCal
//
//  Created by Matt Dolan External macOS on 2021-07-08.
//

import UIKit

class CatCalVC: UIViewController {
    
    //    var catManager = CatManager()
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var dateArray = [String]()
    var dateIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = .white
        view.backgroundColor = .cyan
        tableView.register(CatCalTableViewCell.nib(), forCellReuseIdentifier: CatCalTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        calendarHelper()
        
    }
    
    func calendarHelper() {
        let calendar = Calendar(identifier: .iso8601)
        let startOfWeek = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        let days = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek)  }
        let dateFormatter: DateFormatter = {
            let result = DateFormatter()
            result.dateStyle = .full
            result.timeStyle = .none
            return result
            
        }()
        let todaysIndex = days.firstIndex(of: calendar.startOfDay(for: Date()))
        let dayDisplays = days.map { dateFormatter.string(from: $0) }
        
        dateArray = dayDisplays
        dateIndex = todaysIndex ?? 0
        print(todaysIndex!)
        print(dayDisplays)
    }
}

extension CatCalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CatCalTableViewCell.identifier, for: indexPath) as! CatCalTableViewCell
        
        if dateIndex == indexPath.row {
            cell.backgroundColor = UIColor.blue
            cell.calendarLabel.textColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor.white
            cell.calendarLabel.textColor = UIColor.black
        }
        
        cell.calendarLabel?.text = dateArray[indexPath.row]
        
        return cell
    }
}

extension CatCalVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
//
//extension CatCalTableViewCell: CatManagerDelegate {
//    func didUpdateCatImage(_ catManager: CatManager, urlString: String) {
//        DispatchQueue.main.async {
//        }
//    }
//
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//}

