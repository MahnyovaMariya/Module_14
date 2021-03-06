//
//  Next5WeatherDataLoader.swift
//  Module 14
//
//  Created by Мария on 06.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import Foundation
import Alamofire

struct TempNext {
    var temp: Double = 0
    var pressure: Int = 0
    var humidity: Int = 0
    var clouds: Int = 0
    var speed: Double = 0
    var description: String = ""
    var date: String = ""
}

class Next5WeatherDataLoader {
    
    func loadNext5WeatherDataMainAlamofire(completion: @escaping ([Next5DaysWeatherForecastMain]) -> Void) {
        
        var temporaryTemp: Double = 0
        var temporaryPress: Int = 0
        var temporaryHum: Int = 0
        var temporaryClouds: Int = 0
        var temporarySpeed: Double = 0
        var temporaryDescript: String = ""
        var temporaryDate: String = ""
        
        AF.request("https://api.openweathermap.org/data/2.5/forecast?id=524894&appid=e01a0c729fb326d404e48ef777244be6&lang=ru").responseJSON { response in
            if let objects = response.value,
                let jsonDict = objects as? NSDictionary {
                var nextWeatherDataMain: [Next5DaysWeatherForecastMain] = []
                var tempNextArr: [TempNext] = []
                for (_, data) in jsonDict where data is NSArray{
                    for i in 0...(data as! NSArray).count - 1 {
                        if (data as! NSArray)[i] is NSDictionary {
                            for (_, data1) in (data as! NSArray)[i] as! NSDictionary {
                                if data1 is NSDictionary {
                                    for (index2, data2) in data1 as! NSDictionary {
                                    if index2 as! String == "temp"  {
                                        temporaryTemp = data2 as! Double
                                    } else if index2 as! String == "pressure" {
                                        temporaryPress = data2 as! Int
                                    } else if index2 as! String == "humidity" {
                                        temporaryHum = data2 as! Int
                                    } else if index2 as! String == "all" {
                                        temporaryClouds = data2 as! Int
                                    } else if index2 as! String == "speed" {
                                        temporarySpeed = data2 as! Double
                                    }
                                    }
                                } else if data1 is NSArray {
                                    for index in 0...(data1 as! NSArray).count - 1 {
                                        if (data1 as! NSArray)[index] is NSDictionary {
                                            for (index2, data2) in (data1 as! NSArray)[index] as! NSDictionary {
                                                if index2 as! String == "description" {
                                                    temporaryDescript = data2 as! String
                                                }
                                            }
                                        }
                                    }
                                } else if data1 is String {
                                    temporaryDate = data1 as! String
                                }
                                tempNextArr.append(TempNext(temp: temporaryTemp, pressure: temporaryPress, humidity: temporaryHum, clouds: temporaryClouds, speed: temporarySpeed, description: temporaryDescript, date: temporaryDate))
                            }
                        }
                        if let variableForecast = Next5DaysWeatherForecastMain(dataMain: tempNextArr) {
                        nextWeatherDataMain.append(variableForecast) }
                    }
                    RealmSaveNextWetherForecastData.nextWeatherData.deleteData()
                    RealmSaveNextWetherForecastData.nextWeatherData.addData(tempArr: nextWeatherDataMain)
                }
                DispatchQueue.main.async {
                    completion(nextWeatherDataMain)
                }
            }
        }
    }
}
