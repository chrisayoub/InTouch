//
//  MindViewController.swift
//  InTouch
//
//  Created by Chris on 1/28/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit
import Foundation

class MindViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var seconds = 60 * 10 // 10 MINUTES

    let progressIndicatorView = CircularClockUIView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(progressIndicatorView)
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[v]|", options: .init(rawValue: 0),
            metrics: nil, views: ["v": progressIndicatorView]))
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[v]|", options: .init(rawValue: 0),
            metrics: nil, views:  ["v": progressIndicatorView]))
        progressIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        // Do any additional setup after loading the view.
        
        // create a basic animation that animates the value 'strokeEnd'
        let tempSeconds = seconds
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = CFTimeInterval(tempSeconds)
        animateStrokeEnd.fromValue = 1.0
        animateStrokeEnd.toValue = 0.0
        
        // add the animation
        progressIndicatorView.circlePathLayer.add(animateStrokeEnd, forKey: "animate stroke end animation")
        
        self.timeLabel.text = self.timeString(time: TimeInterval(self.seconds))
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.seconds -= 1
            self.timeLabel.text = self.timeString(time: TimeInterval(self.seconds))
            
            if (self.seconds == 0) {
                timer.invalidate()
            }
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i", minutes, seconds)
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
