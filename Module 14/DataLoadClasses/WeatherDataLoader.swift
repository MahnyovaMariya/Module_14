//
//  WeatherDataLoader.swift
//  Module 14
//
//  Created by Мария on 06.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation
import Alamofire

struct Temp {
    var temp: Double = 0
    var pressure: Int = 0
    var humidity: Int = 0
    var clouds: Int = 0
    var speed: Int = 0
    var description: String = ""
    var name: String = ""
}

class WeatherDataLoader {
    
    func loadWeatherDataMainAlamofire(completion: @escaping ([CurrentMoscowWeatherForecastMain]) -> Void) {

        var temporaryTemp: Double = 0
        var temporaryPress: Int = 0
        var temporaryHum: Int = 0
        var temporaryClouds: Int = 0
        var temporarySpeed: Int = 0
        var temporaryDescript: String = ""
        var temporaryName: String = ""
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?id=524894&appid=e01a0c729fb326d404e48ef777244be6&lang=ru").responseJSON { response in
            if let objects = response.value,
                let jsonDict = objects as? NSDictionary {
                var weatherDataMain: [CurrentMoscowWeatherForecastMain] = []
                var tempArr: [Temp] = []
                for (index, data) in jsonDict {
                    if data is NSDictionary {
                    for (index2, data2) in data as! NSDictionary {
                        if index2 as! String == "temp"  {
                            temporaryTemp = data2 as! Double
                        } else if index2 as! String == "pressure" {
                            temporaryPress = data2 as! Int
                        } else if index2 as! String == "humidity" {
                            temporaryHum = data2 as! Int
                        } else if index2 as! String == "all" {
                            temporaryClouds = data2 as! Int
                        } else if index2 as! String == "speed" {
                            temporarySpeed = data2 as! Int
                        }
                        }
                    } else if data is NSArray {
                        for i in 0...(data as! NSArray).count - 1 {
                            if (data as! NSArray)[i] is NSDictionary {
                                for (index2, data2) in (data as! NSArray)[i] as! NSDictionary {
                                        if index2 as! String == "description"  {
                                            temporaryDescript = data2 as! String
                                    }
                                }
                            }
                        }
                    } else if index as! String == "name" {
                        temporaryName = data as! String
                    }
                }
                tempArr.append(Temp(temp: temporaryTemp, pressure: temporaryPress, humidity: temporaryHum, clouds: temporaryClouds, speed: temporarySpeed, description: temporaryDescript, name: temporaryName))
                if let variableForecast = CurrentMoscowWeatherForecastMain(dataMain: tempArr) { weatherDataMain.append(variableForecast) }
                RealmSaveWetherForecastData.weatherData.deleteData()
                RealmSaveWetherForecastData.weatherData.addData(tempArr: weatherDataMain)
                DispatchQueue.main.async { completion(weatherDataMain) }
                }
        }
    }
}
