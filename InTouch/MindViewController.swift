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

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var isPaused = true
    
    @IBAction func pausePress(_ sender: Any) {
        if isPaused {
            pauseButton.setTitle("Pause", for: .normal)
            pauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.seconds -= 1
                self.timeLabel.text = self.timeString(time: TimeInterval(self.seconds))
                if (self.seconds == 0) {
                    timer.invalidate()
                }
            }
            // create a basic animation that animates the value 'strokeEnd'
            let tempSeconds = seconds
            let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            animateStrokeEnd.duration = CFTimeInterval(tempSeconds)
            animateStrokeEnd.fromValue = (Double) (seconds) / (Double) (originalSeconds)
            animateStrokeEnd.toValue = 0.0
            
           // progressIndicatorView.progress = (CGFloat((Double) (seconds) / (Double) (originalSeconds)))
            
            // add the animation
            progressIndicatorView.circlePathLayer.add(animateStrokeEnd, forKey: "animate stroke end animation")
        } else {
            pauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            pauseButton.setTitle("Resume", for: .normal)
            timer?.invalidate()
           // let tempLen = progressIndicatorView.circlePathLayer.strokeEnd
           // progressIndicatorView.progress = tempLen
            progressIndicatorView.circlePathLayer.removeAllAnimations()
        }
        isPaused = !isPaused
    }
    
    var timer: Timer?
    var seconds = 60 * 10 // 10 MINUTES
    var originalSeconds = 60 * 10 // SAME VALUE

    let progressIndicatorView = CircularClockUIView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setTitle(title: "Mind", subtitle: "Close yours eyes. Breathe. Relax.")
        
        view.addSubview(progressIndicatorView)
//        view.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|[v]|", options: .init(rawValue: 0),
//            metrics: nil, views: ["v": progressIndicatorView]))
//        view.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "H:|[v]|", options: .init(rawValue: 0),
//            metrics: nil, views:  ["v": progressIndicatorView]))
        progressIndicatorView.frame = emptyView.frame
      //  progressIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        self.timeLabel.text = self.timeString(time: TimeInterval(self.seconds))
        pauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        
        // Do any additional setup after loading the view.
        
        // create a basic animation that animates the value 'strokeEnd'
//        let tempSeconds = seconds
//        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
//        animateStrokeEnd.duration = CFTimeInterval(tempSeconds)
//        animateStrokeEnd.fromValue = 1.0
//        animateStrokeEnd.toValue = 0.0
//
//        // add the animation
//        progressIndicatorView.circlePathLayer.add(animateStrokeEnd, forKey: "animate stroke end animation")
//
//        self.timeLabel.text = self.timeString(time: TimeInterval(self.seconds))
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
//            self.seconds -= 1
//            self.timeLabel.text = self.timeString(time: TimeInterval(self.seconds))
//            if (self.seconds == 0) {
//                timer.invalidate()
//            }
//        }
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DataAccess.shared.addMindData(length: Double(originalSeconds - seconds))
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//

    @IBAction func moreTime(_ sender: Any) {
        seconds += 60 * 5 // 5 MIN
        originalSeconds += 60 * 5 // SAME TIME
        
        if isPaused {
            self.timeLabel.text = self.timeString(time: TimeInterval(self.seconds))
            return
        }
        
        // INVALIDATE CURRENT ANIMATION
        timer?.invalidate()
        progressIndicatorView.circlePathLayer.removeAllAnimations()
        // ADD NEW TIME NOW
        
        self.timeLabel.text = self.timeString(time: TimeInterval(self.seconds))
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.seconds -= 1
            self.timeLabel.text = self.timeString(time: TimeInterval(self.seconds))
            if (self.seconds == 0) {
                timer.invalidate()
            }
        }
        // create a basic animation that animates the value 'strokeEnd'
        let tempSeconds = seconds
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = CFTimeInterval(tempSeconds)
        animateStrokeEnd.fromValue = (Double) (seconds) / (Double) (originalSeconds)
        animateStrokeEnd.toValue = 0.0
        
        // add the animation
        progressIndicatorView.circlePathLayer.add(animateStrokeEnd, forKey: "animate stroke end animation")
    }
}
