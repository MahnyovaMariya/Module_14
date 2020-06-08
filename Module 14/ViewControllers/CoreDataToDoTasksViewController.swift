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
    
    @IBOutlet weak var newTaskTextField: UITextField!
    
    @IBAction func addToListButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "List", in: context)
        let newTask = NSManagedObject(entity: entity!, insertInto: context)
        newTask.setValue(newTaskTextField.text, forKey: "task")
        do {
            try context.save()
        } catch {
            print("error")
        }
        taskListTextView.text = ""
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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        request.returnsObjectsAsFaults = false
        let result = try! context.fetch(request)
        for _ in result as! [NSManagedObject]  {
            for j in 0...result.count - 1 {
                if j == Int(numberTaskTextField.text!)! - 1 {
                    context.delete(result[j] as! NSManagedObject)
                }
            }
        }
        do {
            try! context.save()
        }
        taskListTextView.text = ""
      UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
          self.deleteTaskView.alpha = 0
      }, completion: nil)
        numberTaskTextField.text = ""
        viewDidLoad()
    }
    
    @IBOutlet weak var taskListTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var count = 0
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        request.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(request)
            if result .isEmpty {
                taskListTextView.text = "Задачи отсутствуют"
            } else {
            for i in result as! [NSManagedObject] {
                count += 1
                taskListTextView.text.append(contentsOf: "\(count) \(i.value(forKey: "task") as! String)\n")
            }
            count = 0
            }
        }
    }
}
