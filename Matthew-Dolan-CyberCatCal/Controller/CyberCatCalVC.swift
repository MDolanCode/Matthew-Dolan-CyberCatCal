//
//  CyberCatCalVC.swift
//  Matthew-Dolan-CyberCatCal
//
//  Created by Matt Dolan External macOS on 2021-07-08.
//

import UIKit

class CyberCatCalVC: UIViewController {
    
    var cyberCatManager = CyberCatManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cyberCatManager.getCatImage()
    }
}

