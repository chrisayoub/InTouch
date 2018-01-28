//
//  GraphViewController.swift
//  InTouch
//
//  Created by Chris on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var graph: LineChartView!
    @IBOutlet weak var tableView: UITableView!
    
    var currentSegIndex = 0
    
    let cellTitles = ["Mind", "Sleep", "Mood", "Diet"]
    var cells: [GraphTableViewCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        if !UserDefaults.standard.bool(forKey: "popFlag") {
            DataAccess.shared.populateData()
            UserDefaults.standard.set(true, forKey: "popFlag")
            UserDefaults.standard.synchronize()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        graph.chartDescription?.text = ""
        graph.xAxis.labelPosition = XAxis.LabelPosition.bottom
        graph.leftAxis.axisMaximum = 10.0
        graph.leftAxis.axisMinimum = 1.0
        
        graph.rightAxis.enabled = false
        graph.leftAxis.enabled = false
        
        graph.legend.horizontalAlignment = .center
        
        graph.leftAxis.drawGridLinesEnabled = false
        graph.xAxis.drawGridLinesEnabled = false
        
        chartUpdate(interval: .week)
    }
    
    func chartUpdate(interval: DataAccess.graphInterval) {
        // Adding BS data....
//        var entries: [ChartDataEntry] = []
//        for i in 0...3 {
//            let t = Double(i)
//            entries.append(ChartDataEntry(x: (Double) (i), y: (Double) (t)))
//        }
//        let entry1 = LineChartDataSet(values: entries, label: "Test Set")
//        graph.data = LineChartData(dataSets: [entry1])
        
        // Format X Axis
        let format = XAxisFormat()
        format.initVals(interval: interval)
        graph.xAxis.valueFormatter = format
        
        graph.xAxis.axisMinimum = 0.0
        switch (interval) {
        case .month: graph.xAxis.axisMaximum = 30 - 1
        case .year: graph.xAxis.axisMaximum = 12 - 1
        default: graph.xAxis.axisMaximum = 7 - 1
        }
        graph.xAxis.setLabelCount((Int) (graph.xAxis.axisMaximum) + 1, force: true)
        
        var allData: [LineChartDataSet] = []
        let scaleMax = 10.0
        
        // Add real data
        for i in 0..<cells.count {
            if !cells[i].switchTog.isOn {
                continue
            }
            
            if (i == 0) {
                // Mind
                let data = DataAccess.shared.getMindData(interval: interval)
                var entries: [ChartDataEntry] = []
                var max = 0.0
                for e in data {
                    if e.length > max {
                        max = e.length
                    }
                }
                
                for e in data {
                    // Format the date
                    let dateVal = getFormattedDateForChartEntry(date: e.date!, interval: interval)
                    
                    // Add the actual entry
                    let y_val = ((Double)(e.length))/max * scaleMax
                    entries.append(ChartDataEntry(x: (Double) (dateVal), y: y_val))
                }
                let entrySet = LineChartDataSet(values: entries, label: cellTitles[i])
                entrySet.circleColors = [UIColor(red: CGFloat(57)/255.0, green:CGFloat(91)/255.0, blue:CGFloat(112)/255.0, alpha: CGFloat(1.0))]
                entrySet.setColor(UIColor(red: CGFloat(57)/255.0, green:CGFloat(91)/255.0, blue:CGFloat(112)/255.0, alpha: CGFloat(1.0)))
                entrySet.circleRadius = 5
                entrySet.circleHoleRadius = 0
                allData.append(entrySet)
            } else if (i == 1) {
                // Sleep
                let data = DataAccess.shared.getSleepData(interval: interval)
               
                var entries: [ChartDataEntry] = []
                let max = 9.0
                for e in data {
                    // Format the date
                    let dateVal = getFormattedDateForChartEntry(date: e.date!, interval: interval)
                    
                    // Add the actual entry
                    let y_val = ((Double)(e.hoursOfSleep))/max * scaleMax
                    entries.append(ChartDataEntry(x: (Double) (dateVal), y: y_val))
                }
                let entrySet = LineChartDataSet(values: entries, label: cellTitles[i])
                entrySet.circleColors = [UIColor(red: CGFloat(189)/255.0, green:CGFloat(106)/255.0, blue:CGFloat(106)/255.0, alpha: CGFloat(1.0))]
                entrySet.setColor(UIColor(red: CGFloat(189)/255.0, green:CGFloat(106)/255.0, blue:CGFloat(106)/255.0, alpha: CGFloat(1.0)))
                entrySet.circleRadius = 5
                entrySet.circleHoleRadius = 0
                allData.append(entrySet)
            } else if (i == 2) {
                // Mood
                let data = DataAccess.shared.getMoodData(interval: interval)
                var entries: [ChartDataEntry] = []
                let max = 7.0
                for e in data {
                    // Format the date
                    let dateVal = getFormattedDateForChartEntry(date: e.date!, interval: interval)
                    
                    // Add the actual entry
                    let y_val = ((Double)(e.moodVal))/max * scaleMax
                    entries.append(ChartDataEntry(x: (Double) (dateVal), y: y_val))
                }
                let entrySet = LineChartDataSet(values: entries, label: cellTitles[i])
                entrySet.circleColors = [UIColor(red: CGFloat(200)/255.0, green:CGFloat(199)/255.0, blue:CGFloat(132)/255.0, alpha: CGFloat(1.0))]
                entrySet.setColor(UIColor(red: CGFloat(200)/255.0, green:CGFloat(199)/255.0, blue:CGFloat(132)/255.0, alpha: CGFloat(1.0)))
                entrySet.circleRadius = 5
                entrySet.circleHoleRadius = 0
                allData.append(entrySet)
            } else if (i == 3) {
                // Diet
                let data = DataAccess.shared.getDietData(interval: interval)
                var entries: [ChartDataEntry] = []
                for e in data {
                    // Format the date
                    let dateVal = getFormattedDateForChartEntry(date: e.date!, interval: interval)
                    
                    // CALCULATE DIET VALUE HERE
                    var valUse = (Double) (e.hydartion + e.veggies + (8 - e.caffeine) + (8 - e.junk))
                    valUse /= 4.0
                    
                    // Add the actual entry
                    entries.append(ChartDataEntry(x: (Double) (dateVal), y: valUse))
                }
                let entrySet = LineChartDataSet(values: entries, label: cellTitles[i])
                entrySet.circleColors = [UIColor(red: CGFloat(112)/255.0, green:CGFloat(52)/255.0, blue:CGFloat(52)/255.0, alpha: CGFloat(1.0))]
                entrySet.setColor(UIColor(red: CGFloat(112)/255.0, green:CGFloat(52)/255.0, blue:CGFloat(52)/255.0, alpha: CGFloat(1.0)))
                entrySet.circleRadius = 5
                entrySet.circleHoleRadius = 0
                allData.append(entrySet)
            }
            //else if (i == 4) {
//                // Goals
//                let data = DataAccess.shared.getGoalData(interval: interval)
//                var entries: [ChartDataEntry] = []
//                var dict = Dictionary<Int, Int>()
//                for e in data {
//                    // Format the date
//                    let dateVal = getFormattedDateForChartEntry(date: e.date!, interval: interval)
//
//                    // Add the actual entry
//                    if (e.done) {
//                        if (dict[dateVal] == nil) {
//                            dict[dateVal] = 1
//                        } else {
//                            dict[dateVal] = dict[dateVal]! + 1
//                        }
//                    }
//                }
//                for (key, val) in dict {
//                    let k = (Double) (key)
//                    let v = (Double) (val)
//                    entries.append(ChartDataEntry(x: k, y: v))
//                }
//                let entrySet = LineChartDataSet(values: entries, label: cellTitles[i])
//                allData.append(entrySet)
//            }
        }
        
        graph.data = LineChartData(dataSets: allData)
        graph.data?.setDrawValues(false)
 
        
        //This must stay at end of function
        graph.notifyDataSetChanged()
    }
    
    @IBAction func segControl(_ sender: UISegmentedControl, forEvent event: UIEvent) {
        currentSegIndex = sender.selectedSegmentIndex
        doFullChartUpdate()
    }
    
    func doFullChartUpdate() {
        var timeInterval: DataAccess.graphInterval
        
        switch currentSegIndex {
        case 0:
            timeInterval = .week
        case 1:
            timeInterval = .month
        default:
            timeInterval = .year
        }
        
        chartUpdate(interval: timeInterval)
    }
    
    func getFormattedDateForChartEntry(date: Date, interval: DataAccess.graphInterval) -> Int {
        // Format the date
        let cal = Calendar.current
        let current = Date()
        
        var baseInt = 0
        var labelCount = 0
        switch (interval) {
        case .month:
            baseInt = cal.dateComponents([.day], from: date, to: current).day!;
            labelCount = 30
        case .year:
            baseInt = cal.dateComponents([.month], from: date, to: current).month!;
            labelCount = 12
        default:
            baseInt = cal.dateComponents([.day], from: date, to: current).day!;
            labelCount = 7
        }
        let axisPos = labelCount - 1 - baseInt
        return axisPos
    }
    
    // Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "graphCell", for: indexPath) as! GraphTableViewCell
        cells.append(cell)
        cell.selectionStyle = .none
        cell.config(title: cellTitles[indexPath.item], parent: self)
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
