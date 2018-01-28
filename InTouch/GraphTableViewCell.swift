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
    @IBOutlet weak var switchTog: UISwitch!
    var parent: GraphViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    func config(title: String, parent: GraphViewController) {
        label.text = title
        self.parent = parent
    }
    
    @IBAction func toggleSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
        parent?.doFullChartUpdate()
    }
}
