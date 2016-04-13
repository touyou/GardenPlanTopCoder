//
//  BedsTableViewCell.swift
//  GardenPlanTopCoder
//
//  Created by 藤井陽介 on 2016/04/09.
//  Copyright © 2016年 藤井陽介. All rights reserved.
//

import UIKit

class BedsTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var flowerView1: UIView!
    @IBOutlet var flowerView2: UIView!
    @IBOutlet var flowerView3: UIView!
    @IBOutlet var flowerView4: UIView!
    @IBOutlet var flowerView5: UIView!
    @IBOutlet var flowerLabel1: UILabel!
    @IBOutlet var flowerLabel2: UILabel!
    @IBOutlet var flowerLabel3: UILabel!
    @IBOutlet var flowerLabel4: UILabel!
    @IBOutlet var flowerLabel5: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        flowerView1.backgroundColor = UIColor.whiteColor()
        flowerView2.backgroundColor = UIColor.whiteColor()
        flowerView3.backgroundColor = UIColor.whiteColor()
        flowerView4.backgroundColor = UIColor.whiteColor()
        flowerView5.backgroundColor = UIColor.whiteColor()
        flowerLabel1.text = ""
        flowerLabel2.text = ""
        flowerLabel3.text = ""
        flowerLabel4.text = ""
        flowerLabel5.text = ""
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func reset() {
        flowerView1.backgroundColor = UIColor.whiteColor()
        flowerView2.backgroundColor = UIColor.whiteColor()
        flowerView3.backgroundColor = UIColor.whiteColor()
        flowerView4.backgroundColor = UIColor.whiteColor()
        flowerView5.backgroundColor = UIColor.whiteColor()
        flowerLabel1.text = ""
        flowerLabel2.text = ""
        flowerLabel3.text = ""
        flowerLabel4.text = ""
        flowerLabel5.text = ""
    }
}
