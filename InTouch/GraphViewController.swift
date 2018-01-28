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

    @IBOutlet weak var graph: BarChartView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        barChartUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func barChartUpdate() {
        let entry1 = BarChartDataEntry(x: 1.0, y: 50.0)
        let entry2 = BarChartDataEntry(x: 2.0, y: 60.0)
        let entry3 = BarChartDataEntry(x: 3.0, y: 35.0)
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "DataSet1")
        let data = BarChartData(dataSets: [dataSet])
        graph.data = data
        graph.chartDescription?.text = "Number of Stuff by Type"
        
        //All other additions to this function will go here
        
        
        //This must stay at end of function
        graph.notifyDataSetChanged()
    }
    
    @IBAction func segControl(_ sender: UISegmentedControl, forEvent event: UIEvent) {
        
    }
    
    // Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as! GraphTableViewCell
        
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
