//
//  ActionViewController.swift
//  InTouch
//
//  Created by User on 1/28/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {

    @IBOutlet weak var exercise: UILabel!
    
    var counter = 0
    let exercises: [String] = ["Do pushups for 30 seconds at a comfortable pace. Make sure to not let your butt sag or stick up! Adjust the time as you progress.", "Plank for 45 seconds. Remember to not let your butt lift or sag and make sure to keep your head up. It's normal for it to hurt! Adjust the time as you progress.", "Do squats for 1 minute. Make sure to keep your feet shoulder-width apart and not let your knees buckle inwards! Adjust the time as you progress.", "Try lunging in an open area for 1 minute. Don't allow your knees to touch the floor! Adjust the time as you progress."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercise.text = exercises[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newExercise(_ sender: Any) {
        counter += 1
        if (counter >= exercises.count) {
            counter = 0
        }
        exercise.text = exercises[counter]
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
