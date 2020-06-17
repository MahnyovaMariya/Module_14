//
//  ListCoreDataTableViewCell.swift
//  Module 14
//
//  Created by Мария on 13.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import UIKit
import CoreData

class ListCoreDataTableViewCell: UITableViewCell {

    @IBOutlet weak var numberTaskLabel: UILabel!
    @IBOutlet weak var taskLabel: UITextField!
    @IBAction func clickTaskLabel(_ sender: Any) { saveChangesButton.isHidden = false }
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBAction func clickSaveChangesButton(_ sender: Any) {
        
        CoreDataMakeToDoList().changeTaskValue(number: Int(numberTaskLabel.text!)!, task: taskLabel.text!)
        saveChangesButton.isHidden = true
    }
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func clickCheckButton(_ sender: Any) {
        
        checkButton.isHidden = true
        CoreDataMakeToDoList().changeCheckValue(number: Int(numberTaskLabel.text!)!)
        self.accessoryType = UITableViewCell.AccessoryType.checkmark
    }
        
    override func awakeFromNib() { super.awakeFromNib() }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
}
