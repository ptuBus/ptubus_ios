//
//  SchoolBusTableViewCell.swift
//  ptuBus
//
//  Created by rokong.me on 2021/06/08.
//

import UIKit

class SchoolBusTableViewCell: UITableViewCell {
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainLabel.adjustsFontSizeToFitWidth = true
        subLabel.adjustsFontSizeToFitWidth = true
    }

    @IBAction func favoriteButton(_ sender: Any) {
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
