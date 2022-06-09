//
//  Forecast.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 01/06/22.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    var hours: [Hour]?
    var meta: Meta?
}

// MARK: - Hour
struct Hour: Codable {
    var swellDirection: SwellDirection?
    var time: String?
    var waveHeight, wavePeriod, windDirection, windSpeed: SwellDirection?
}

// MARK: - SwellDirection
struct SwellDirection: Codable {
    var icon, meteo, noaa, sg: Double?
}

// MARK: - Meta
struct Meta: Codable {
    var cost, dailyQuota: Int?
    var end: String?
    var lat, lng: Double?
    var params: [String]?
    var requestCount: Int?
    var start: String?
}

