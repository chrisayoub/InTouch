//
//  ActionViewController.swift
//  InTouch
//
//  Created by User on 1/28/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var exercise: UILabel!
    
    var counter = 0
    let exercises: [String] = ["Do pushups for 30 seconds at a comfortable pace. Make sure to not let your butt sag or stick up! Adjust the time as you progress.", "Plank for 45 seconds. Remember to not let your butt lift or sag and make sure to keep your head up. It's normal for it to hurt! Adjust the time as you progress.", "Do squats for 1 minute. Make sure to keep your feet shoulder-width apart and not let your knees buckle inwards! Adjust the time as you progress.", "Try lunging in an open area for 1 minute. Don't allow your knees to touch the floor! Adjust the time as you progress.", "Do 1 minute of jumping jacks. Try to keep your legs and arms in sync. Adjust the time as you progress.", "Do 1 minute of crunches. Make sure to lift with your abs and not your back or neck. If you're struggling, try lightly supporting your head with your arms. Adjust the time as you progress.", "Do 1 minute of high knees in place. Challenge yourself to keep a consistent height! Adjust the time as you progress.", "Do chair step-ups for 1 minute. Make sure to alterate what foot steps-up! Adjust the time as you progress."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 189 106 106
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 16
        button.layer.borderColor = UIColor(red: 189/255.0, green: 106/255.0, blue: 106/255.0, alpha: 1.0).cgColor
        
        navigationItem.setTitle(title: "Action", subtitle: "Go the extra mile.")
        
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
