
import Foundation
import SwiftUI

struct CurrentWeather: View{
    var weather: Weather?
    var height: CGFloat = 0
    
    var body: some View{
        VStack(alignment: .center){
            Text("WeatherApp")
                .font(.largeTitle)
                .bold()
                .padding(60)
                .shadow(color: .gray, radius: 12)
                .foregroundColor(Color.white)
                Spacer()
            
                Image(uiImage: "https://openweathermap.org/img/wn/\(weather?.weather[0].icon ?? "")@2x.png".load())
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180, alignment: .center)
            
                Text("\(weather?.main.temp.round ?? 0) °C")
                    .foregroundColor(.white)
                    .fontWeight(Font.Weight.heavy)
                    .font(.system(size: 65))
                .shadow(color: .gray, radius: 6)
            
                Text("\(weather?.name ?? "Unknown")")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding(.bottom, 300)
                .shadow(color: .gray, radius: 6)
            Spacer()
        }
        .background(
        Image("light_background")
            .resizable()
            .scaledToFill()
            .clipped())
            .edgesIgnoringSafeArea([.top, .bottom])
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

struct CurrentWeather_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeather()
    }
}
