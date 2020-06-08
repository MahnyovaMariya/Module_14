//
//  ViewController.swift
//  Module 14
//
//  Created by Мария on 01.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var informationView: UIView!
    
    @IBAction func saveButton(_ sender: Any) {
        
        PersonalData.shared.lastName = lastNameTextField.text
        PersonalData.shared.firstName = firstNameTextField.text
        informationView.frame.origin = CGPoint(x: self.view.frame.size.width / 2 - informationView.frame.size.width / 2, y: self.view.frame.size.height / 2 - informationView.frame.size.height / 2)
        self.informationView.alpha = 0
        UIView.animate(withDuration: 0.9, delay: 0, options: [.curveLinear, .autoreverse], animations: {
            self.informationView.alpha = 0.5
        }) { (isCompleted) in
            self.informationView.alpha = 0
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        lastNameTextField.text = PersonalData.shared.lastName
        firstNameTextField.text = PersonalData.shared.firstName
    }
}

