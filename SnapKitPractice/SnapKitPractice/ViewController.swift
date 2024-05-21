//
//  ViewController.swift
//  SnapKitPractice
//
//  Created by 윤해수 on 5/21/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var box = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(box)
        box.backgroundColor = .green
        box.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
    }
}
