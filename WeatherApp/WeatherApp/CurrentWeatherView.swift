
import Foundation
import Combine

final class CurrentWeatherViewModel:
ObservableObject{
    @Published var current: Weather?
    
    init(){
        self.fetch()
    }
}

extension CurrentWeatherViewModel{
    func fetch(by city: String = "Lappeenranta") {
        WeatherApi.fetchCurrentWeather(by: city) {
            self.current = $0
        }
    }
}
