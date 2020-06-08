//
//  RealmSaveWetherForecastData.swift
//  Module 14
//
//  Created by Мария on 07.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherData: Object {
    
    @objc dynamic var city = ""
    @objc dynamic var temperature = 0.0
    @objc dynamic var pressure = 0
    @objc dynamic var humidity = 0
    @objc dynamic var windSpeed = 0
    @objc dynamic var cloudness = 0
    @objc dynamic var condition = ""
}

class RealmSaveWetherForecastData {
    
    static let weatherData = RealmSaveWetherForecastData()
    private let realm = try! Realm()
    
    func addData(tempArr:[CurrentMoscowWeatherForecastMain]){
        let record = WeatherData()
        record.city = tempArr[0].name
        record.temperature = Double(tempArr[0].mainTemp) ?? 0.0
        record.pressure = Int(tempArr[0].mainPressure) ?? 0
        record.humidity = tempArr[0].mainHumidity
        record.windSpeed = tempArr[0].windSpeed
        record.cloudness = tempArr[0].cloudsAll
        record.condition = tempArr[0].description
        try! realm.write {
            realm.add(record)
        }
    }
    
    func selectData() -> [WeatherData] {
        var tempArr = [WeatherData]()
        for record in realm.objects(WeatherData.self) {
            tempArr.append(record)
        }
        return tempArr
    }
    
    func deleteData() {
        let allRecords = realm.objects(WeatherData.self)
        for record in allRecords {
            try! realm.write{
                realm.delete(record)
            }
        }
    }
}
