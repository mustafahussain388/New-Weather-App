//
//  WeatherModel.swift
//  My Weather App
//
//  Created by Mustafa on 13/12/19.
//  Copyright © 2019 Mustafa. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName:String
    let conditionId:Int
    let temperature:Double
    
    var temperatureString:String{
        return String(format:"%.1f", temperature)
    }
    
    var conditionType:String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
    }
}
