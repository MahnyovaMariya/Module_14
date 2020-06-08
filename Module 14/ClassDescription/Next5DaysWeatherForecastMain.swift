//
//  Next5DaysWeatherForecastMain.swift
//  Module 14
//
//  Created by Мария on 06.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation

class Next5DaysWeatherForecastMain {
    
    var mainTemp: String = ""
    var mainPressure: String = ""
    var mainHumidity: Int = 0
    var cloudsAll: Int = 0
    var windSpeed: Double = 0
    var description: String = ""
    var date: String = ""

    init?(dataMain: Array<TempNext>) {
            
        for i in 0...dataMain.count - 1 {
            let mainTemp = dataMain[i].temp
            let mainPressure = dataMain[i].pressure
            let mainHumidity = dataMain[i].humidity
            let cloudsAll = dataMain[i].clouds
            let windSpeed = dataMain[i].speed
            let description = dataMain[i].description
            let date = dataMain[i].date
            
            self.mainTemp = String(format: "%.1f", Double(mainTemp) - 273.15)
            self.mainPressure = String(format: "%.1f", Double(mainPressure)/1.333)
            self.mainHumidity = mainHumidity
            self.cloudsAll = cloudsAll
            self.windSpeed = windSpeed
            self.description = description
            self.date = date
        }
    }
}
