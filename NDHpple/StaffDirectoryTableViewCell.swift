//
//  StaffDirectoryTableViewCell.swift
//  Indata App V2
//
//  Created by IUPUI on 2/20/16.
//  Copyright © 2016 Nicolai Davidsson. All rights reserved.
//

import UIKit


class StaffDirectoryTableViewCell: UITableViewCell {

    @IBOutlet weak var staffNameLabel: UILabel!
    @IBOutlet weak var staffEmailLabel: UILabel!
    @IBOutlet weak var staffPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
