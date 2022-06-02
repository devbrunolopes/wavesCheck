//
//  Forecast.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 01/06/22.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    var hours: [Hour]
    var meta: Meta
}

// MARK: - Hour
struct Hour: Codable {
    var swellDirection: SwellDirection
    var time: Date
    var waveHeight, wavePeriod: [String: Double]
    var windDirection, windSpeed: Wind
}

// MARK: - SwellDirection
struct SwellDirection: Codable {
    var dwd, icon: Double?
    var meteo, noaa, sg: Double
}

// MARK: - Wind
struct Wind: Codable {
    var icon: Double?
    var noaa, sg, smhi: Double
}

// MARK: - Meta
struct Meta: Codable {
    var cost, dailyQuota: Int
    var end: String
    var lat, lng: Double
    var params: [String]
    var requestCount: Int
    var start: String
}
