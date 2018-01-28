//
//  SleepViewController.swift
//  InTouch
//
//  Created by User on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit
import VerticalSteppedSlider

class SleepViewController: UIViewController {
    
    @IBOutlet weak var sleepSlider: VSSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sleepSlider.minimumValue = 1
        sleepSlider.maximumValue = 9
        sleepSlider.increment = 1
        sleepSlider.vertical = false
        sleepSlider.trackWidth = 5
        sleepSlider.value = (sleepSlider.maximumValue + sleepSlider.minimumValue) / 2
        let col1 = UIColor(red: 189/255.0, green: 106/255.0, blue: 106/255.0, alpha: 1)
        sleepSlider.minimumTrackTintColor = col1
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DataAccess.shared.addSleepData(hours: (Int64) (sleepSlider.value))
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
