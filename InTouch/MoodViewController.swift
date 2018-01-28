//
//  MoodViewController.swift
//  InTouch
//
//  Created by User on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class MoodViewController: UIViewController {

    @IBOutlet weak var sad: UIButton!
    @IBOutlet weak var neutral: UIButton!
    @IBOutlet weak var happy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func sadPress(_ sender: Any) {
        DataAccess.shared.addMoodData(moodVal: (Int64) (2))
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func neutralPress(_ sender: Any) {
        DataAccess.shared.addMoodData(moodVal: (Int64) (4))
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func happyPress(_ sender: Any) {
        DataAccess.shared.addMoodData(moodVal: (Int64) (6))
        self.navigationController?.popViewController(animated: true)
    }
}
