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
    
    // MARK: - IBOutlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = .white
        
        tableView.register(CatCalTableViewCell.nib(), forCellReuseIdentifier: CatCalTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // URLSession
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.thecatapi.com/v1/images/search?limit=7")!), completionHandler: { data, _, error in
            if let data = data {
                let cats = try! JSONDecoder().decode([Cat].self, from: data)
                DispatchQueue.main.async {
                    self.configureCells(cats: cats)
                    
                    // Debug console to show
                    print(cats)
                }
            }
            else {
                print(error as Any)
            }
        }).resume()
    }
    
    // MARK: - Configure Cells
    func configureCells(cats: [Cat]) {
        let calendar = Calendar(identifier: .iso8601)
        let startOfWeek = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        let days = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek)  }
        let today = calendar.startOfDay(for: Date())        
        
        displayables = zip(days, cats).map { date, cat in
            CellDisplayable(
                backgroundColor: date == today ? .blue : .white,
                textColor: date == today ? .white : .black,
                text: dateFormatter.string(from: date),
                currentDay: date == today,
                url: cat.url
            )
        }
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CatCalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CatCalTableViewCell.identifier, for: indexPath) as! CatCalTableViewCell
        
        let displayable = displayables[indexPath.row]        
        cell.configure(displayable: displayable)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CatCalVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
