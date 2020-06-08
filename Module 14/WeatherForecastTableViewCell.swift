//
//  WeatherForecastTableViewCell.swift
//  Module 14
//
//  Created by Мария on 06.06.2020.
//  Copyright © 2020 Мария. All rights reserved.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBOutlet weak var mainTempLabel: UILabel!
    
    @IBOutlet weak var mainPressureLabel: UILabel!
    
    @IBOutlet weak var mainHumidityLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var cloudnessLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
