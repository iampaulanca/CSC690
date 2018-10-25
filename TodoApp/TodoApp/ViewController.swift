//
//  ViewController.swift
//  TodoApp
//
//  Created by Paul Ancajima on 10/22/18.
//  Copyright © 2018 Paul Ancajima. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tasks : [Task] = []
    var completedTasks : [Task] = []
    var temp : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fetech objects from core data
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            let tasks = try PersistenceService.context.fetch(fetchRequest)
            self.tasks = tasks
            self.tableView.reloadData()
        } catch { }
        
    }
    
    //Show all task
    @IBAction func allTaskActionButton(_ sender: Any) {
        viewDidLoad()
        tableView.reloadData()
    }
    
    //Show all completed tasks
    @IBAction func completedActionButton(_ sender: Any) {
        if !hasSameTasks(tasks1: tasks, tasks2: completedTasks){
            temp = tasks
            completedTasks = findAllCompleted(tasks: tasks)
            tasks = completedTasks
            tableView.reloadData()
        }
    }
    
    //UITableView object
    @IBOutlet weak var tableView: UITableView!
    
    //Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //Populate rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.taskNameLabel.text = tasks[indexPath.row].name
        if tasks[indexPath.row].checked {
            cell.checkBoxOutlet.borderColor = UIColor.black
            cell.checkBoxOutlet.borderWidth = 5
            cell.checkBoxOutlet.cornerRadius = 5
            cell.checkBoxOutlet.backgroundColor = UIColor.blue
        } else {
            cell.checkBoxOutlet.borderColor = UIColor.black
            cell.checkBoxOutlet.borderWidth = 5
            cell.checkBoxOutlet.cornerRadius = 5
            cell.checkBoxOutlet.backgroundColor = UIColor.white
        }
        
        cell.delagate = self
        cell.indexP = indexPath.row
        cell.tasks = tasks
        
        return cell
    }
    
    //Need to prep segue in order to add tasks
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddTaskController
        vc.delagate = self
    }
    
    //Delete tasks
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            //Must delete
            PersistenceService.context.delete(tasks[indexPath.row])
            tasks.remove(at: indexPath.row)
        }
        PersistenceService.saveContext()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        alert.addTextField { (textfield) in textfield.placeholder = self.tasks[indexPath.row].name}
        
        let action = UIAlertAction(title: "Edit", style: .default){ (_) in
            self.tasks[indexPath.row].name = alert.textFields!.first!.text!
            tableView.reloadData()
            PersistenceService.saveContext()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
}

//Adding a task. Protocol found in AddTaskController
extension ViewController : AddTask {
    func addTask(name: String) {
        let task = Task(context: PersistenceService.context)
        task.name = name
        tasks.append(task)
        PersistenceService.saveContext()
        tableView.reloadData()
    }
}

//Changing completed status or "checkBox". Protocol found in TaskCell
extension ViewController : ChangeButton {
    func changeButton(checkBox: Bool, index: Int) {
        tasks[index].checked = checkBox
        PersistenceService.saveContext()
        tableView.reloadData()
    }
}

//Find task by name. Helper method
func findTask(tasks: [Task], name: String) -> Int{
    if tasks.count > 0 {
        for i in 0...tasks.count-1 {
            if tasks[i].name == name {
                return i
            }
        }
    }
    return -1
}

//Find all completed tasks. Used in completedActionButton
func findAllCompleted(tasks: [Task]) -> [Task] {
    var temp : [Task] = []
    if tasks.count > 0 {
        for i in 0...tasks.count-1 {
            if tasks[i].checked == true {
                temp.append(tasks[i])
            }
        }
    }
    return temp
}

//Print all task helper method
func printAllTask(tasks: [Task]){
    if tasks.count > 0 {
        for i in 0...tasks.count-1 {
            print(tasks[i].name! , " is " , tasks[i].checked)
        }
    }
}

//Compare two Task arrays. Used in completedActionButton
func hasSameTasks(tasks1: [Task], tasks2: [Task]) -> Bool{
    if tasks1.count > 0 && tasks2.count > 0 && tasks1.count == tasks2.count {
        for i in 0...tasks1.count-1 {
            if(tasks1[i].name == tasks2[i].name && tasks1[i].checked == tasks2[i].checked){
                return true
            } else {
                return false
            }
        }
    }
    return false
}


//For easy editing to button-borders and button-corners in storyboard
@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
