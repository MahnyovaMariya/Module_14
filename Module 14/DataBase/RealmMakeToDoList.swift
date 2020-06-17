//
//  RealmMakeToDoList.swift
//  Module 14
//
//  Created by Мария on 02.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation
import RealmSwift

class Task2: Object {
    @objc dynamic var taskName = ""
    @objc dynamic var check = false
}

class RealmMakeToDoList {
    
    static let data = RealmMakeToDoList()
    private let realm = try! Realm()
    
    func addTask(taskName: String, check: Bool) {
        let task = Task2()
        task.taskName = taskName
        task.check = check
        try! realm.write { realm.add(task) }
    }
    
    func selectTasks() -> [MakeTaskElem] {
        var tempArr1 = [Task2]()
        var tempArr2 = [MakeTaskElem]()
        for task in realm.objects(Task2.self) {
            tempArr1.append(task)
            let tempVariable = MakeTaskElem(listArray: tempArr1)
            tempArr2.append(tempVariable)
            }
        return tempArr2
    }
       
    func deleteTask(taskNumber: String){
        let allTasks = realm.objects(Task2.self)
        for (index, task) in allTasks.enumerated() {
            if index == Int(taskNumber)! - 1 {
                try! realm.write { realm.delete(task) }
            }
        }
    }
    
    func rewriteTask(number: Int, taskName: String, check: Bool) {
        let elem = Task2()
        elem.taskName = taskName
        elem.check = check
        let allTasks = realm.objects(Task2.self)
        for (index, task) in allTasks.enumerated() {
            if index == number - 1 {
                try! realm.write {
                    task.taskName = taskName
                    task.check = check
                }
            }
        }
    }
    
}
