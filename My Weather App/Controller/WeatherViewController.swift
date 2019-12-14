


import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchTextField.delegate = self
        
    }
}
//MARK: - UITextFieldDelegate

extension WeatherViewController:UITextFieldDelegate{
    
    @IBAction func searchButton(_ sender: UIButton) {
           searchTextField.endEditing(true)
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           searchTextField.endEditing(true)
           return true
       }
       
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if textField.text != "" {
               return true
           } else {
               textField.placeholder = "Type City Name"
               return false
           }
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
           if let city = searchTextField.text {
               weatherManager.fetchWeather(cityName: city)
           }
           searchTextField.text = ""
       }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController:WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel) {
           DispatchQueue.main.sync {
               self.temperatureLabel.text = weather.temperatureString
               self.conditionImageView.image = UIImage(systemName: weather.conditionType)
               self.cityLabel.text = weather.cityName
           }
           
       }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController:CLLocationManagerDelegate{
    
    @IBAction func locationPressed(_ sender: UIButton) {
           locationManager.requestLocation()
       }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


