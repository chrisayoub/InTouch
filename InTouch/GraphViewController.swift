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
    
    let cellTitles = ["Mind", "Sleep", "Mood", "Diet", "Goals"]
    var cells: [GraphTableViewCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        graph.chartDescription?.text = ""
        graph.xAxis.labelPosition = XAxis.LabelPosition.bottom
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
        case .month: graph.xAxis.axisMaximum = 4 - 1
        case .year: graph.xAxis.axisMaximum = 12 - 1
        default: graph.xAxis.axisMaximum = 7 - 1
        }
        graph.xAxis.setLabelCount((Int) (graph.xAxis.axisMaximum) + 1, force: true)
        
        var allData: [LineChartDataSet] = []
        
        // Add real data
        for i in 0..<cells.count {
            if !cells[i].switchTog.isOn {
                continue
            }
            
            if (i == 0) {
                let data = DataAccess.shared.getMindData(interval: interval)
                var entries: [ChartDataEntry] = []
                for e in data {
                    // Format the date
                    let dateVal = getFormattedDateForChartEntry(date: e.date, interval: interval)
                    
                    // Add the actual entry
                    entries.append(ChartDataEntry(x: (Double) (dateVal), y: e.length))
                }
                let entrySet = LineChartDataSet(values: entries, label: cellTitles[i])
                allData.append(entrySet)
            } else if (i == 1) {
                
            } else if (i == 2) {
                
            } else if (i == 3) {
                
            } else {
                
            }
        }
        
        graph.data = ChartData(dataSets: allData)
        
        //This must stay at end of function
        graph.notifyDataSetChanged()
    }
    
    @IBAction func segControl(_ sender: UISegmentedControl, forEvent event: UIEvent) {
        var timeInterval: DataAccess.graphInterval
        
        switch sender.selectedSegmentIndex {
        case 0:
            timeInterval = .week
        case 1:
            timeInterval = .month
        default:
            timeInterval = .year
        }
        
        chartUpdate(interval: timeInterval)
    }
    
    func getFormattedDateForChartEntry(date: Int64, interval: DataAccess.graphInterval) -> Int {
        // Format the date
        let diff = Date().timeIntervalSinceReferenceDate.bitPattern - (UInt64) (date)
        let dateConvDiff = Date(timeIntervalSinceReferenceDate: TimeInterval(diff))
        let cal = Calendar.current
        
        var baseInt = 0
        var labelCount = 0
        switch (interval) {
        case .month: baseInt = cal.component(.weekOfMonth, from: dateConvDiff); labelCount = 4
        case .year: baseInt = cal.component(.month, from: dateConvDiff); labelCount = 12
        default: baseInt = cal.component(.weekday, from: dateConvDiff); labelCount = 7
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
        cell.config(title: cellTitles[indexPath.item])
        
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
