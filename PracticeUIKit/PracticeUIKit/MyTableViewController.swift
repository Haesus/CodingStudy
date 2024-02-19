//
//  MyTableViewController.swift
//  PracticeUIKit
//
//  Created by 윤해수 on 2/1/24.
//

import UIKit

class MyTableViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    
    let friendNames = ["Tag", "Tom", "Jin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        myTableView.backgroundColor = .blue
        myTableView.delegate = self
        myTableView.dataSource = self
    }
}

extension MyTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendNames.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myFirstCell", for: indexPath)
        
        cell.textLabel?.text = friendNames[indexPath.row]
        
        return cell
    }
}
