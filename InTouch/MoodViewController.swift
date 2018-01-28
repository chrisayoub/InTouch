//
//  MoodViewController.swift
//  InTouch
//
//  Created by User on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit
import VerticalSteppedSlider

class MoodViewController: UIViewController {

    @IBOutlet weak var moodSlider: VSSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moodSlider.minimumValue = 1
        moodSlider.maximumValue = 7
        moodSlider.increment = 1
        moodSlider.vertical = false
        moodSlider.trackWidth = 15
        moodSlider.value = (moodSlider.maximumValue + moodSlider.minimumValue) / 2
        
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

}
