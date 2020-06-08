//
//  RealmToDoTasksViewController.swift
//  
//
//  Created by Мария on 02.06.2020.
//

import UIKit

class RealmToDoTasksViewController: UIViewController {

    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var taskListTextView: UITextView!
    
    @IBAction func addToListButton(_ sender: Any) {
        
        RealmMakeToDoList.data.addTask(taskName: newTaskTextField.text!)
        taskListTextView.text = ""
        newTaskTextField.text = ""
        viewDidLoad()
    }
    
    @IBOutlet weak var deleteTaskView: UIView!
    @IBOutlet weak var numberTaskTextField: UITextField!
    
    @IBAction func deleteTaskButton(_ sender: Any) {
        
        let number = numberTaskTextField.text!
        RealmMakeToDoList.data.deleteTask(taskNumber: number)
        taskListTextView.text = ""
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.deleteTaskView.alpha = 0
        }, completion: nil)
        numberTaskTextField.text = ""
        viewDidLoad()
    }
    
    @IBAction func deleteFromListButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.deleteTaskView.alpha = 1
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let array = RealmMakeToDoList.data.selectTasks()
        if array .isEmpty {
            taskListTextView.text = "Задачи отсутствуют"
        } else {
            for i in 0...array.count - 1 {
                taskListTextView.text.append(contentsOf: "\(i + 1) \(array[i].taskName)\n")
            }
        }
    }
}
