//
//  EditDiaryEntryViewController.swift
//  InTouch
//
//  Created by Chris on 1/27/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

protocol ViewControllerEditDiaryEntryDelegate: class {
    
    func textEdited(text:String?)
    
}

class EditDiaryEntryViewController: UIViewController {
    
    var data: String?
    @IBOutlet weak var mainText: UITextView!
    weak var delegate: ViewControllerEditDiaryEntryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainText.text = data

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
            delegate?.textEdited(text: data)
        }
    }

}
