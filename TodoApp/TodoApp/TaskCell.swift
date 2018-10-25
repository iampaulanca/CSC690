//
//  TaskCell.swift
//  TodoApp
//
//  Created by Paul Ancajima on 10/22/18.
//  Copyright © 2018 Paul Ancajima. All rights reserved.
//

import UIKit

protocol ChangeButton{
    func changeButton(checkBox: Bool, index: Int)
}

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBAction func checkBoxAction(_ sender: Any) {
        
        //if true or task is completed
        if tasks![indexP!].checked {
            delagate?.changeButton(checkBox: false, index: indexP!)
        } else {
            delagate?.changeButton(checkBox: true, index: indexP!)
        }
    }
    @IBOutlet weak var taskNameLabel: UILabel!
    
    var delagate : ChangeButton?
    var indexP : Int?
    var tasks : [Task]?
    
}
