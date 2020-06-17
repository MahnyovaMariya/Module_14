//
//  RealmToDoTasksViewController.swift
//  
//
//  Created by Мария on 02.06.2020.
//

import UIKit

class RealmToDoTasksViewController: UIViewController {
    
    var arrayOfTasks: [MakeTaskElem] = []
    @IBOutlet weak var tableTasksTableView: UITableView!
    @IBOutlet weak var newTaskTextField: UITextField!
    @IBAction func addToListButton(_ sender: Any) {
        
        RealmMakeToDoList.data.addTask(taskName: newTaskTextField.text!, check: false)
        newTaskTextField.text = ""
        viewDidLoad()
    }
    @IBOutlet weak var deleteTaskView: UIView!
    @IBOutlet weak var numberTaskTextField: UITextField!
    @IBAction func deleteTaskButton(_ sender: Any) {
        
        RealmMakeToDoList.data.deleteTask(taskNumber: numberTaskTextField.text!)
        hideView()
        numberTaskTextField.text = ""
        viewDidLoad()
        self.tableTasksTableView.reloadData()
    }
    @IBAction func deleteFromListButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.deleteTaskView.alpha = 1
        }, completion: nil)
    }
    @IBAction func cancelButton(_ sender: Any) { hideView() }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let array = RealmMakeToDoList.data.selectTasks()
        arrayOfTasks = array
        if array .isEmpty {
            print("Задачи отсутствуют")
        }
        self.tableTasksTableView.reloadData()
    }
    
    func hideView() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.deleteTaskView.alpha = 0
        }, completion: nil)
    }
}

extension RealmToDoTasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableTasksTableView.dequeueReusableCell(withIdentifier: "Cell") as! ListTableViewCell
        if arrayOfTasks .isEmpty {
            cell.numberTaskLabel.text = ""
            cell.taskLabel.text = ""
            cell.checkButton.isHidden = false
        } else {
            cell.numberTaskLabel.text = String(indexPath.row + 1)
            cell.taskLabel.text = arrayOfTasks[indexPath.row].task
            if arrayOfTasks[indexPath.row].check == true {
                cell.checkButton.isHidden = true
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            } else if arrayOfTasks[indexPath.row].check == false {
                cell.checkButton.isHidden = false
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        }
        return cell
    }
}
