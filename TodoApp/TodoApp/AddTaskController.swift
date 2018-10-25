//
//  AddTaskController.swift
//  TodoApp
//
//  Created by Paul Ancajima on 10/22/18.
//  Copyright © 2018 Paul Ancajima. All rights reserved.
//

import UIKit

protocol AddTask{
    func addTask(name:String)
}

class AddTaskController: UIViewController {
    
    var delagate: AddTask?
    
    @IBOutlet weak var taskNameOutlet: UITextField!
    @IBAction func addActionButton(_ sender: Any) {
        if taskNameOutlet.text != "" {
            delagate?.addTask(name: taskNameOutlet.text!)
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   
}
