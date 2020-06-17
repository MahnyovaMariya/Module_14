//
//  CoreDataToDoTasksViewController.swift
//  Module 14
//
//  Created by Мария on 03.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import UIKit
import CoreData

class CoreDataToDoTasksViewController: UIViewController {
    
    var arrayOfTasks: [NSManagedObject] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newTaskTextField: UITextField!
    @IBAction func addToListButton(_ sender: Any) {
        
        CoreDataMakeToDoList().addToList(task: newTaskTextField.text!, check: false)
        newTaskTextField.text = ""
        viewDidLoad()
    }
    @IBAction func deleteFromListButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.deleteTaskView.alpha = 1
        }, completion: nil)
    }
    @IBOutlet weak var deleteTaskView: UIView!
    @IBOutlet weak var numberTaskTextField: UITextField!
    @IBAction func deleteTaskButton(_ sender: Any) {
        
        CoreDataMakeToDoList().deleteFromList(number: Int(numberTaskTextField.text!)!)
        hideView()
        numberTaskTextField.text = ""
        viewDidLoad()
        self.tableView.reloadData()
    }
    @IBAction func cancelButton(_ sender: Any) { hideView() }
    
    func hideView() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.deleteTaskView.alpha = 0
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrayOfTasks = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            let result = try! context.fetch(request)
            if result .isEmpty {
                print("Задачи отсутствуют")
            } else {
                for i in result as! [NSManagedObject] {
                    arrayOfTasks.append(i)
                }
            }
        } catch {}
        self.tableView.reloadData()
    }
}

extension CoreDataToDoTasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ListCoreDataTableViewCell
        if arrayOfTasks .isEmpty {
            cell.numberTaskLabel.text = ""
            cell.taskLabel.text = ""
            cell.checkButton.isHidden = false
        } else {
            cell.numberTaskLabel.text = String(indexPath.row + 1)
            cell.taskLabel.text = arrayOfTasks[indexPath.row].value(forKey: "task") as? String
            if arrayOfTasks[indexPath.row].value(forKey: "check") as? Bool == true {
                cell.checkButton.isHidden = true
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            } else if arrayOfTasks[indexPath.row].value(forKey: "check") as? Bool == false {
                cell.checkButton.isHidden = false
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        }
        return cell
    }
}
