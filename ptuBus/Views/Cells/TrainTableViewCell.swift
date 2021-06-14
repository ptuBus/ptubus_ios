//
//  TrainTableViewCell.swift
//  ptuBus
//
//  Created by rokong.me on 2021/06/14.
//

import UIKit

class TrainTableViewCell: UITableViewCell {
    @IBOutlet var trainClassLabel: UILabel!
    @IBOutlet var boardTimeLabel: UILabel!
    @IBOutlet var departureTimeLabel: UILabel!
    @IBOutlet var lineNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
