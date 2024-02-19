//
//  ViewController.swift
//  PracticeUIKit
//
//  Created by 윤해수 on 2/1/24.
//

import UIKit

class ViewController: UIViewController {
    
    let friendsNames = ["Tag", "Tom", "Jin"]
    var count = 0
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        nameLabel.text = friendsNames[count]
        if count < 2 {
            count += 1
        } else {
            count = 0
        }
    }
}

