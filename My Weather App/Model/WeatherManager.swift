//
//  WeatherManager.swift
//  My Weather App
//
//  Created by Mustafa on 13/12/19.
//  Copyright © 2019 Mustafa. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(weather:WeatherModel)
}
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5cb49cadedb42d52db4bdd1a313b2cb3&units=metric"
    
    var delegate:WeatherManagerDelegate?
    
    func fetchWeather(cityName:String){
        let urlString = ("\(weatherURL)&q=\(cityName)")
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude:CLLocationDegrees, longitude:CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString:String){
        //1. Create a URL
        if let url = URL(string: urlString){
            //2. Create a URL Session
            let session = URLSession(configuration: .default)
            //3. Give the session a Task
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            //4. Start the Task
            task.resume()
        }
    }
    
    func parseJSON(weatherData:Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temperature = decodedData.main.temp
            let weather = WeatherModel(cityName:name , conditionId: id, temperature: temperature)
            return weather
            
        } catch {
            print(error)
            return nil
        }
    }
    
}
