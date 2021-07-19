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
    
    var task: URLSessionTask?
    
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
    
    // MARK: - PrepareForReuse
    // To cancel the download if the cell gets reused before the download completed
    // and to remove the old image.
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        catImageView.image = nil
    }
    
    // MARK: - Configure Cell Displayable
    // Downloads the images and puts them into an array of [catImageView].
    func configure(displayable: CellDisplayable) {
        task = URLSession.shared.dataTask(with: URLRequest(url: displayable.url)) { [catImageView] data, _, _ in
            if let data = data {
                // Sets the UI for the cells.
                DispatchQueue.main.async {
                    self.backgroundColor = displayable.backgroundColor
                    self.calendarLabel.textColor = displayable.textColor
                    self.calendarLabel.text = displayable.text
                    catImageView?.image = UIImage(data: data)
                }
            }
        }
        task!.resume()
    }
}
