//
//  HistoryTableViewCell.swift
//  SectionMatt
//
//  Created by Rohan Nagesh on 7/3/17.
//  Copyright © 2017 Rohan Nagesh. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var completionTime: UILabel!
    @IBOutlet weak var exerciseList: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
