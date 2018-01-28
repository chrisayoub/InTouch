//
//  DiaryTableViewCell.swift
//  InTouch
//
//  Created by Chris on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    var parent: DiaryTableViewController?
    var cellIndex: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
