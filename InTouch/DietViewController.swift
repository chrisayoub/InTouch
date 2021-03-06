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

    @IBOutlet weak var button: UIButton!
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
        CaffeineSlider.trackWidth = 5
        CaffeineSlider.value = (CaffeineSlider.maximumValue + CaffeineSlider.minimumValue) / 2
        HydrationSlider.minimumValue = 1
        HydrationSlider.maximumValue = 7
        HydrationSlider.increment = 1
        HydrationSlider.vertical = false
        HydrationSlider.trackWidth = 5
        HydrationSlider.value = (HydrationSlider.maximumValue + HydrationSlider.minimumValue) / 2
        VeggiesSlider.minimumValue = 1
        VeggiesSlider.maximumValue = 7
        VeggiesSlider.increment = 1
        VeggiesSlider.vertical = false
        VeggiesSlider.trackWidth = 5
        VeggiesSlider.value = (VeggiesSlider.maximumValue + VeggiesSlider.minimumValue) / 2
        JunkSlider.minimumValue = 1
        JunkSlider.maximumValue = 7
        JunkSlider.increment = 1
        JunkSlider.vertical = false
        JunkSlider.trackWidth = 5
        JunkSlider.value = (JunkSlider.maximumValue + JunkSlider.minimumValue) / 2
        let col1 = UIColor(red: 189/255.0, green: 106/255.0, blue: 106/255.0, alpha: 1)
        CaffeineSlider.minimumTrackTintColor = col1
        HydrationSlider.minimumTrackTintColor = col1
        VeggiesSlider.minimumTrackTintColor = col1
        JunkSlider.minimumTrackTintColor = col1
        
        // Button
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 16
        button.layer.borderColor = UIColor(red: 189/255.0, green: 106/255.0, blue: 106/255.0, alpha: 1.0).cgColor
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
    @IBAction func submit(_ sender: Any) {
        DataAccess.shared.addDietData(caffeine: (Int64) (VeggiesSlider.value), hydration: (Int64) (CaffeineSlider.value), junk: (Int64) (JunkSlider.value), veggies: (Int64) (HydrationSlider.value))
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
