//
//  RealmSaveWetherForecastData.swift
//  Module 14
//
//  Created by Мария on 07.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherData1: Object {
    
    @objc dynamic var city = ""
    @objc dynamic var temperature = ""
    @objc dynamic var pressure = ""
    @objc dynamic var humidity = 0
    @objc dynamic var windSpeed = 0
    @objc dynamic var cloudness = 0
    @objc dynamic var condition = ""
}

class RealmSaveWetherForecastData {
    
    static let weatherData = RealmSaveWetherForecastData()
    private let realm = try! Realm()
    
    func addData(tempArr:[CurrentMoscowWeatherForecastMain]){
        let record = WeatherData1()
        record.city = tempArr[0].name
        record.temperature = tempArr[0].mainTemp
        record.pressure = tempArr[0].mainPressure
        record.humidity = tempArr[0].mainHumidity
        record.windSpeed = tempArr[0].windSpeed
        record.cloudness = tempArr[0].cloudsAll
        record.condition = tempArr[0].description
        try! realm.write {
            realm.add(record)
        }
    }
    
    func selectData() -> [WeatherData1] {
        
        var tempArr = [WeatherData1]()
        for record in realm.objects(WeatherData1.self) {
            tempArr.append(record)
        }
        return tempArr
    }
    
    func deleteData() {
        let allRecords = realm.objects(WeatherData1.self)
        for record in allRecords {
            try! realm.write{
                realm.delete(record)
            }
        }
    }
}
