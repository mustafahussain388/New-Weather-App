//
//  WeatherData.swift
//  My Weather App
//
//  Created by Mustafa on 13/12/19.
//  Copyright © 2019 Mustafa. All rights reserved.
//

import Foundation

struct WeatherData:Codable {
    let name:String
    let main:Main
    let weather:[Weather]
}
struct Main:Codable {
    let temp:Double
}
struct Weather:Codable {
    let description:String
    let id:Int
}
