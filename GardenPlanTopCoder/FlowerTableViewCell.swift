//
//  FlowerTableViewCell.swift
//  GardenPlanTopCoder
//
//  Created by 藤井陽介 on 2016/04/10.
//  Copyright © 2016年 藤井陽介. All rights reserved.
//

import UIKit

class FlowerTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var colorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
