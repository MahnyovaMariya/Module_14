//
//  MakeTaskElem.swift
//  Module 14
//
//  Created by Мария on 11.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation

class MakeTaskElem {

    var task = ""
    var check = false
    
    init(listArray: Array<Task2>) {
        
        for i in 0...listArray.count - 1 {
            let task = listArray[i].taskName
            let check = listArray[i].check
    
            self.task = task
            self.check = check
        }  
    }
}
