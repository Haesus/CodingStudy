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
    let box1 = UIView()
    let box2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(box2)
        box2.backgroundColor = .red
        box2.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 40, left: 20, bottom: 20, right: 20))
        }
        
        self.view.addSubview(box1)
        box1.backgroundColor = .blue
        box1.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(100)
            make.center.equalTo(self.view)
        }
        
        self.view.addSubview(box)
        box.backgroundColor = .green
        box.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
    }
}
