//
//  GraphTableViewCell.swift
//  InTouch
//
//  Created by Chris on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class GraphTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    func config(title: String) {
        label.text = title
    }
    
    @IBAction func toggleSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
        
    }
}
