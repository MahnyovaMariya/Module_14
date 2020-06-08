//
//  RealmSaveNextWetherForecastData.swift
//  Module 14
//
//  Created by Мария on 07.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation
import RealmSwift

class NextWeatherData: Object {
    @objc dynamic var date = ""
    @objc dynamic var temperature = 0.0
    @objc dynamic var pressure = 0
    @objc dynamic var humidity = 0
    @objc dynamic var windSpeed = 0.0
    @objc dynamic var cloudness = 0
    @objc dynamic var condition = ""
}

class RealmSaveNextWetherForecastData {
    
    static let nextWeatherData = RealmSaveNextWetherForecastData()
    private let realm = try! Realm()
    
    func addData(tempArr:[Next5DaysWeatherForecastMain]){
        let record = NextWeatherData()
        for i in 0...tempArr.count - 1 {
            record.date = tempArr[i].date
            record.temperature = Double(tempArr[i].mainTemp) ?? 0.0
            record.pressure = Int(tempArr[i].mainPressure) ?? 0
            record.humidity = tempArr[i].mainHumidity
            record.windSpeed = tempArr[i].windSpeed
            record.cloudness = tempArr[i].cloudsAll
            record.condition = tempArr[i].description
        }
        try! realm.write {
            realm.add(record)
        }
    }
    
    func selectData() -> [NextWeatherData] {
        var tempArr = [NextWeatherData]()
        for record in realm.objects(NextWeatherData.self) {
            tempArr.append(record)
        }
        return tempArr
    }
    
    func deleteData() {
        let allRecords = realm.objects(NextWeatherData.self)
        for record in allRecords {
            try! realm.write{
                realm.delete(record)
            }
        }
    }
}
