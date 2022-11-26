//
//  Model.swift
//  TZ1
//
//  Created by Даниил on 21.11.22.
//

import Foundation
import UIKit

struct Model: Decodable  {
    var city: String?
    var temperature: String?
    var description: String?
    var weather_per_day: [WeatherPerDay]?
    var forecast: [Forecast]?
}

struct WeatherPerDay: Decodable {
    var timestamp: String?
    var weather_type: String?
    var temperature: String?
}

struct Forecast: Decodable {
    var date: String?
    var min_temperature: Int?
    var max_temperature: Int?
    var weather_type: String?
}
    

