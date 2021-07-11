//
//  CatCalVC.swift
//  Matthew-Dolan-CyberCatCal
//
//  Created by Matt Dolan External macOS on 2021-07-08.
//

import UIKit

class CatCalVC: UIViewController {
    
    var catManager = CatManager()
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = .white
        view.backgroundColor = .cyan
        tableView.register(CatCalTableViewCell.nib(), forCellReuseIdentifier: CatCalTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        catManager.getCatImage()
    }
}

extension CatCalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CatCalTableViewCell.identifier, for: indexPath) as! CatCalTableViewCell
        
        return cell
    }
}

extension CatCalVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}

