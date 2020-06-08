//
//  PersonalData.swift
//  Module 14
//
//  Created by Мария on 01.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation

class PersonalData {
    
    static let shared = PersonalData()
    private let kLastNameKey = "PersonalData.kLastNameKey"
    private let kFirstNameKey = "PersonalData.kFirstNameKey"
    
    var lastName: String? {
        set {UserDefaults.standard.set(newValue, forKey: kLastNameKey)}
        get { return UserDefaults.standard.string(forKey: kLastNameKey)}
    }
    
    var firstName: String? {
        set {UserDefaults.standard.set(newValue, forKey: kFirstNameKey)}
        get { return UserDefaults.standard.string(forKey: kFirstNameKey)}
    }
}
