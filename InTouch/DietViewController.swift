//
//  DietViewController.swift
//  InTouch
//
//  Created by User on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit
import VerticalSteppedSlider

class DietViewController: UIViewController {

    @IBOutlet weak var CaffeineSlider: VSSlider!
    @IBOutlet weak var HydrationSlider: VSSlider!
    @IBOutlet weak var VeggiesSlider: VSSlider!
    @IBOutlet weak var JunkSlider: VSSlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CaffeineSlider.minimumValue = 1
        CaffeineSlider.maximumValue = 7
        CaffeineSlider.increment = 1
        CaffeineSlider.vertical = false
        CaffeineSlider.trackWidth = 15
        CaffeineSlider.value = (CaffeineSlider.maximumValue + CaffeineSlider.minimumValue) / 2
        HydrationSlider.minimumValue = 1
        HydrationSlider.maximumValue = 7
        HydrationSlider.increment = 1
        HydrationSlider.vertical = false
        HydrationSlider.trackWidth = 15
        HydrationSlider.value = (HydrationSlider.maximumValue + HydrationSlider.minimumValue) / 2
        VeggiesSlider.minimumValue = 1
        VeggiesSlider.maximumValue = 7
        VeggiesSlider.increment = 1
        VeggiesSlider.vertical = false
        VeggiesSlider.trackWidth = 15
        VeggiesSlider.value = (VeggiesSlider.maximumValue + VeggiesSlider.minimumValue) / 2
        JunkSlider.minimumValue = 1
        JunkSlider.maximumValue = 7
        JunkSlider.increment = 1
        JunkSlider.vertical = false
        JunkSlider.trackWidth = 15
        JunkSlider.value = (JunkSlider.maximumValue + JunkSlider.minimumValue) / 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DataAccess.shared.addDietData(caffeine: (Int64) (CaffeineSlider.value), hydration: (Int64) (HydrationSlider.value), junk: (Int64) (JunkSlider.value), veggies: (Int64) (VeggiesSlider.value))
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
