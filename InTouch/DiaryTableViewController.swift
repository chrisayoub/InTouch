//
//  DiaryTableViewController.swift
//  InTouch
//
//  Created by Chris on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class DiaryTableViewController: UITableViewController, ViewControllerDiaryEntryDelegate, ViewControllerEditDiaryEntryDelegate {
       
    var cellArray: [Diary] = []
    var data: String?
    var editIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diaryCell", for: indexPath)
        
        // Extract lines
        var lines: [String] = []
        cellArray[indexPath.item].message?.enumerateLines { line, _ in
            lines.append(line)
        }
        if lines.count > 0 {
            cell.textLabel?.text = lines[0]
        }
        else {
            cell.textLabel?.text = ""
        }
        
        // Date
        let date = Date()
        // let calendar = Calendar.current
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        let date_string = dateFormatter.string(from: date)
        
        cell.detailTextLabel?.text = date_string

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewControllerDiaryEntry = segue.destination as? DiaryNewEntryViewController {
            viewControllerDiaryEntry.data = data
            viewControllerDiaryEntry.delegate = self
        }
        if let viewControllerEditDiaryEntry = segue.destination as? EditDiaryEntryViewController {
            viewControllerEditDiaryEntry.data = data
            viewControllerEditDiaryEntry.delegate = self
        }
        if segue.identifier == "editDiaryEntry" {
            let vc = segue.destination as! EditDiaryEntryViewController
            vc.data = cellArray[((tableView.indexPathForSelectedRow?.row)!)].message
            editIndex = ((tableView.indexPathForSelectedRow?.row)!)
        }
    }
    
    func updateData() {
        cellArray = DataAccess.shared.getDiaryData()
        tableView.reloadData()
    }
    
    func textSubmitted(text: String?) {
        let submission = text!
        if submission.count > 0 {
            DataAccess.shared.addDiaryData(diaryText: submission)
            updateData()
        }
    }
    
    func textEdited(text: String?) {
        let submission = text!
        cellArray[editIndex!].message = submission
        DataAccess.shared.saveContext()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let elem = cellArray.remove(at: indexPath.row)
            DataAccess.shared.deleteEntity(entity: elem)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

    }

}
