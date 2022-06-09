//
//  ForecastService.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 09/06/22.
//

import Foundation

protocol ForecastServiceProtocol: GenericService {
    func getForecast(completion: @escaping completion<[Hour]?>)
}

class ForecastService: ForecastServiceProtocol {
    func getForecast(completion: @escaping completion<[Hour]?>) {
        let forecastURL: String = "https://api.stormglass.io/v2"
        
        let urlString: String = "\(forecastURL)/weather/point?lat=\(-17.84649323280926)&lng=\(-149.26349967363493)&params=waveHeight,swellDirection,wavePeriod,windSpeed,windDirection"
        
        guard let url: URL = URL(string: urlString) else {
            return completion(nil, Error.errorDescription(message: "Erro de URL"))
        }
        
        let header = ["Authorization": "4bb0326e-d55e-11ec-9346-0242ac130002-4bb032e6-d55e-11ec-9346-0242ac130002"]
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = header
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let _data = data else {
                return completion(nil, Error.errorDescription(message: "Sem data"))
            }
            
            let json = try? JSONSerialization.jsonObject(with: _data)
            print(json as Any)
            
            guard let response = response as? HTTPURLResponse else {
                return completion(nil, Error.errorDescription(message: "Falha conversão HTTPURLResponse"))
            }
            
            if response.statusCode == 200 {
                do {
                    let decodedData = try JSONDecoder().decode(Forecast.self, from: _data)
                    completion(decodedData.hours, nil)
                } catch {
                    completion(nil, Error.errorDescription(message: "Deu ruim no PARSE", error: error))
                }
            } else {
                completion(nil, Error.errorDescription(message: "Deu ruim", error: error))
            }
        }
        task.resume()
    }
}
