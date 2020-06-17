//
//  CoreDataMakeToDoList.swift
//  Module 14
//
//  Created by Мария on 15.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CoreDataMakeToDoList {
    
    func addToList(task: String, check: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "List", in: context)
        let newTask = NSManagedObject(entity: entity!, insertInto: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        let result = try! context.fetch(request)
        do {
            newTask.setValue(result.count + 1, forKey: "number")
            newTask.setValue(task, forKey: "task")
            newTask.setValue(check, forKey: "check")
            do {
                try context.save()
            } catch {}
        } catch {}
    }
    
    func deleteFromList(number: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        let result = try! context.fetch(request)
        do {
            for _ in result as! [NSManagedObject]  {
                for j in 0...result.count - 1 {
                    if j == number - 1 {
                        context.delete(result[j] as! NSManagedObject)
                        do {
                            try context.save()
                        } catch {}
                    }
                }
            }
        } catch {}
    }
        
    func changeCheckValue(number: Int) {
           
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        let result = try! context.fetch(request)
        do {
            if result .isEmpty {
                print("Задачи отсутствуют")
            } else {
                for i in result as! [NSManagedObject] {
                    if let numb = i.value(forKey: "number") {
                        if numb as! Int == number + 1 {
                            i.setValue(true, forKey: "check")
                            do {
                                try context.save()
                            } catch {}
                        }
                    }
                }
           }
        } catch {}
    }
    
    func changeTaskValue(number: Int, task: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        let result = try! context.fetch(request)
        do {
            if result .isEmpty {
                print("Задачи отсутствуют")
            } else {
                for i in result as! [NSManagedObject] {
                    if let numb = i.value(forKey: "number") {
                        if numb as! Int == number + 1 {
                            i.setValue(task, forKey: "task")
                            do {
                                try context.save()
                            } catch {
                                
                            }
                        }
                    }
                }
            }
        } catch {}
    }
}
    

    

