//
//  CustomImageView.swift
//  InTouch
//
//  Created by User on 1/28/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    let progressIndicatorView = CircularClockUIView(frame: .zero)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(progressIndicatorView)
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[v]|", options: .init(rawValue: 0),
            metrics: nil, views: ["v": progressIndicatorView]))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[v]|", options: .init(rawValue: 0),
            metrics: nil, views:  ["v": progressIndicatorView]))
        progressIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
