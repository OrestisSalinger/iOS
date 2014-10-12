//
//  TaskCellTableViewCell.swift
//  Task It
//
//  Created by Orestis Salinger on 05.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

class XingVisitorCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var reason: UILabel!
    
    @IBOutlet weak var visitDate: UILabel!
    
    @IBOutlet weak var visitCount: UILabel!
    
    @IBOutlet weak var visitorPicture: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
