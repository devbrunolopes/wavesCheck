//
//  ForecastTableViewCellViewModel.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 09/06/22.
//

import Foundation

class ForecastTableViewCellViewModel {
    func getSwellDirectionString(parametro: Double) -> String {
        
        switch parametro {
        case 0...45:
            return "N"
        case 46...90:
            return "NE"
        case 91...135:
            return "E"
        case 136...180:
            return "SE"
        case 181...225:
            return "S"
        case 226...270:
            return "SO"
        case 271...315:
            return "O"
        default:
            return "NO"
        }
    }
    
    func getWindDirectionString(parametro: Double) -> String {
        
        switch parametro {
        case 0...45:
            return "N"
        case 46...90:
            return "NE"
        case 91...135:
            return "E"
        case 136...180:
            return "SE"
        case 181...225:
            return "S"
        case 226...270:
            return "SO"
        case 271...315:
            return "O"
        default:
            return "NO"
        }
    }
}
