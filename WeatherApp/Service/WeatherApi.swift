import Foundation

private let baseUrlForCurrentWeather = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
private let appid = "1adfcdb6b64b59edcd01d5fae37b8f86"

private var decoder: JSONDecoder {
    let decode = JSONDecoder()
    decode.keyDecodingStrategy = .convertFromSnakeCase
    return decode
}

import SwiftUI

class WeatherApi {
    class func fetchCurrentWeather(by city: String, onSuccess: @escaping (Weather) -> Void){
            let query = ["q": "\(city)", "appid": appid, "units": "metric"]
            guard let url = baseUrlForCurrentWeather.withQueries(queries: query) else {
                fatalError()
                
    }
        print(url)
        
    URLSession.shared.dataTask(with: url) { (data, res, err) in
        guard let data = data, err == nil else {
            fatalError(err!.localizedDescription)
            
        }
        do {
            let weather = try decoder.decode(Weather.self, from: data)
            DispatchQueue.main.async {
                onSuccess(weather)
                
            }
        }
        catch {
            print(error)
        }
    }.resume()
    }
}

extension URL {
    func withQueries(queries: [String: String]) -> URL? {
        guard var component = URLComponents(url: self, resolvingAgainstBaseURL: true)
            else {
                fatalError()
        }
        component.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value)}
        return component.url
    }
}
