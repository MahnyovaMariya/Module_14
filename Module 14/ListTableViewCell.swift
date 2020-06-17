//
//  ListTableViewCell.swift
//  Module 14
//
//  Created by Мария on 11.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var numberTaskLabel: UILabel!
    @IBOutlet weak var taskLabel: UITextField!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBAction func clickSaveChangesButton(_ sender: Any) {
        
        let tempCheck = false
        checkButton.isHidden == false ? tempCheck : !tempCheck
        RealmMakeToDoList.data.rewriteTask(number: Int(numberTaskLabel.text!)!, taskName: taskLabel.text!, check: tempCheck)
        saveChangesButton.isHidden = true
    }
    @IBAction func clickTaskLabel(_ sender: Any) { saveChangesButton.isHidden = false }
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func clickCheckButton(_ sender: Any) {
        
        checkButton.isHidden = true
        let tempArray = RealmMakeToDoList.data.selectTasks()
        for i in 0...tempArray.count - 1 {
            if i == Int(numberTaskLabel.text!)! - 1 {
                RealmMakeToDoList.data.rewriteTask(number: Int(numberTaskLabel.text!)!, taskName: taskLabel.text!, check: true)
            }
        }
        self.accessoryType = UITableViewCell.AccessoryType.checkmark
    }
    
    override func awakeFromNib() { super.awakeFromNib() }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }

}
