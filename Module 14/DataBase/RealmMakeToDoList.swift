//
//  RealmMakeToDoList.swift
//  Module 14
//
//  Created by Мария on 02.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var taskName = ""
}

class RealmMakeToDoList {
    
    static let data = RealmMakeToDoList()
    private let realm = try! Realm()
    
    func addTask(taskName: String) {
        let task = Task()
        task.taskName = taskName
        try! realm.write {
            realm.add(task)
        }
    }
    
    func selectTasks() -> [Task] {
        var tempArr = [Task]()
        for task in realm.objects(Task.self) {
            tempArr.append(task)
        }
        return tempArr
    }
    
    func deleteTask(taskNumber: String){
        let allTasks = realm.objects(Task.self)
        for (index, task) in allTasks.enumerated() {
            if index == Int(taskNumber)! - 1 {
                try! realm.write {
                    realm.delete(task)
                }
            }
        }
    }
    
}
