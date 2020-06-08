//
//  WeatherForecastViewController.swift
//  Module 14
//
//  Created by Мария on 06.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var mainTempLabel: UILabel!
    @IBOutlet weak var mainPressureLabel: UILabel!
    @IBOutlet weak var mainHumidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var cloudnessLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var weatherDataMain: [CurrentMoscowWeatherForecastMain] = []
    var nextWeatherDataMain: [Next5DaysWeatherForecastMain] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let array = RealmSaveWetherForecastData.weatherData.selectData()
        if array .isEmpty {
            cityNameLabel.text = ""
            mainTempLabel.text = ""
            mainPressureLabel.text = ""
            mainHumidityLabel.text = ""
            windSpeedLabel.text = ""
            cloudnessLabel.text = ""
            weatherDescriptionLabel.text = ""
        } else {
            cityNameLabel.text = array[0].city
            mainTempLabel.text = String(array[0].temperature)
            mainPressureLabel.text = String(array[0].pressure)
            mainHumidityLabel.text = String(array[0].humidity)
            windSpeedLabel.text = String(array[0].windSpeed)
            cloudnessLabel.text = String(array[0].cloudness)
            weatherDescriptionLabel.text = array[0].condition
        }
        WeatherDataLoader().loadWeatherDataMainAlamofire{ weatherDataMain in
            self.weatherDataMain = weatherDataMain
            self.mainTempLabel.text = self.weatherDataMain[0].mainTemp
            self.mainPressureLabel.text = self.weatherDataMain[0].mainPressure
            self.mainHumidityLabel.text = String(self.weatherDataMain[0].mainHumidity)
            self.cloudnessLabel.text = String(self.weatherDataMain[0].cloudsAll)
            self.windSpeedLabel.text = String(self.weatherDataMain[0].windSpeed)
            self.weatherDescriptionLabel.text = self.weatherDataMain[0].description
            self.cityNameLabel.text = self.weatherDataMain[0].name
            RealmSaveWetherForecastData.weatherData.deleteData()
            RealmSaveWetherForecastData.weatherData.addData(tempArr: self.weatherDataMain)
        }
        
        Next5WeatherDataLoader().loadNext5WeatherDataMainAlamofire { nextWeatherDataMain in
            self.nextWeatherDataMain = nextWeatherDataMain
            self.tableView.reloadData()
        }
    }
}

extension WeatherForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nextWeatherDataMain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! WeatherForecastTableViewCell
        let array = RealmSaveNextWetherForecastData.nextWeatherData.selectData()
        if array .isEmpty {
            cell.mainTempLabel.text = ""
            cell.mainPressureLabel.text = ""
            cell.mainHumidityLabel.text = ""
            cell.cloudnessLabel.text = ""
            cell.windSpeedLabel.text = ""
            cell.weatherDescriptionLabel.text = ""
            cell.currentDateLabel.text = ""
        } else {
            for i in 0...array.count - 1 {
                cell.mainTempLabel.text = String(array[i].temperature)
                cell.mainPressureLabel.text = String(array[i].pressure)
                cell.mainHumidityLabel.text = String(array[i].humidity)
                cell.cloudnessLabel.text = String(array[i].cloudness)
                cell.windSpeedLabel.text = String(array[i].windSpeed)
                cell.weatherDescriptionLabel.text = array[i].condition
                cell.currentDateLabel.text = array[i].date
            }
        }
        let obj1 = nextWeatherDataMain[indexPath.row]
        cell.mainTempLabel.text = obj1.mainTemp
        cell.mainPressureLabel.text = obj1.mainPressure
        cell.mainHumidityLabel.text = String(obj1.mainHumidity)
        cell.cloudnessLabel.text = String(obj1.cloudsAll)
        cell.windSpeedLabel.text = String(obj1.windSpeed)
        cell.weatherDescriptionLabel.text = obj1.description
        cell.currentDateLabel.text = obj1.date
        RealmSaveNextWetherForecastData.nextWeatherData.deleteData()
        RealmSaveNextWetherForecastData.nextWeatherData.addData(tempArr: nextWeatherDataMain)
        return cell
    }
}
