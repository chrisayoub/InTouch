//
//  DiaryNewEntryViewController.swift
//  InTouch
//
//  Created by Chris on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

protocol ViewControllerDiaryEntryDelegate: class {
    
    func textSubmitted(text:String?)
    
}

class DiaryNewEntryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var mainText: UITextView!
    var erased = false
    var data: String?
    weak var delegate: ViewControllerDiaryEntryDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        mainText.delegate = self
        mainText.text = "What's on your mind?"
        mainText.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController {
            data = mainText.text
            delegate?.textSubmitted(text: data)
        }
    }
   

    func textViewDidBeginEditing(_ textView: UITextView) {
        if !erased {
            textView.text = ""
            mainText.textColor = UIColor.black
        }
        erased = true
    }
    
}
