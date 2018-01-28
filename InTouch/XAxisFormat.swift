//
//  XAxisFormat.swift
//  InTouch
//
//  Created by Chris on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit
import Foundation
import Charts

@objc(XAxisFormat)
public class XAxisFormat: NSObject, IAxisValueFormatter {
    
    var values: [String] = []
    
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    func initVals(interval: DataAccess.graphInterval) {
        values = []
        var date = Date()
        let calendar = Calendar.current
        //let hour = calendar.component(.hour, from: date)
        //let minutes = calendar.component(.minute, from: date)
        var month = calendar.component(.month, from: date)
        if (interval == .year) {
            var i = 0
            while (i < 12) {
                values.append(months[month])
                month = (month + 1) % 12
                i += 1
            }
        } else if (interval == .month) {
            values = ["Week 1", "Week 2", "Week 3", "Week 4"]
        } else if (interval == .week) {
            var i = 0
            while (i < 7) {
                date.addTimeInterval(DataAccess.day)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEE"
                let day = dateFormatter.string(from: date)
                values.append(day)
                i += 1
            }
        }
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return values[Int(value)]
    }
}
