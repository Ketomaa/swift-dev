//
//  ContentView.swift
//  WeatherApp
//
//  Created by Tatu Ketomaa on 24.1.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selected =  0
    @ObservedObject var weather = CurrentWeatherViewModel()
    @State var city: String = ""
    
    var body: some View {
        VStack() {
            TextField("Enter your city", text: $city, onCommit: {
                self.weather.fetch(by: self.city)
            }).padding(.horizontal)
            
            GeometryReader{ gr in
                CurrentWeather(weather: self.weather.current, height: self.selected == 0 ?
                               gr.size.height : gr.size.height * 0.50).animation(.easeInOut(duration: 1.5))
                
            }
        }
    }
}

extension Double {
    var round: Int {
        return Int(self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MainWeatherView: View {
    var temperature: Int
    var weather: Weather?
    var body: some View {
        VStack(spacing: 8) {
            Image(uiImage: "https://openweathermap.org/img/wn/\(weather?.weather[0].icon ?? "")@2x.png".load())
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180, alignment: .center)
            Text(weather?.weather[0].description ?? "")
                .font(.system(size: 30, weight: .medium))
                .foregroundColor(.white)
            Text("\(String(format: "%.1f", weather?.main.temp ?? 0)) °C")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

extension String {
    func load() -> UIImage {
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            let data: Data = try
            Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        return UIImage()
    }
}
