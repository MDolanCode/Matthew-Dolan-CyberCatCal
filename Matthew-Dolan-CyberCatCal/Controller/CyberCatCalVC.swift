//
//  CyberCatCalVC.swift
//  Matthew-Dolan-CyberCatCal
//
//  Created by Matt Dolan External macOS on 2021-07-08.
//

import UIKit

class CyberCatCalVC: UIViewController {
    
    var cyberCatManager = CyberCatManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CatCalTableViewCell.nib(), forCellReuseIdentifier: CatCalTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        cyberCatManager.getCatImage()
    }
}

extension CyberCatCalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CatCalTableViewCell.identifier, for: indexPath) as! CatCalTableViewCell
        
        return cell
    }
}

extension CyberCatCalVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}

