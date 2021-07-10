//
//  CatCalTableViewCell.swift
//  Matthew-Dolan-CyberCatCal
//
//  Created by Matt Dolan External macOS on 2021-07-10.
//

import UIKit

class CatCalTableViewCell: UITableViewCell {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var calendarLabel: UILabel!
    
    static let identifier = "CatCalTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CatCalTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
