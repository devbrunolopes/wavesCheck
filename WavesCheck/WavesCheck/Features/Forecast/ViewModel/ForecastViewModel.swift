//
//  ForecastViewModel.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 01/06/22.
//

import Foundation
import UIKit

protocol ForecastViewModelDelegate: AnyObject {
    func success()
    func error()
}

class ForecastViewModel {
    
    private weak var delegate: ForecastViewModelDelegate?
    
    public func delegate(delegate:ForecastViewModelDelegate) {
        self.delegate = delegate
    }
    
    let dates: [String] = [ "Quinta-feira 09/06", "Sexta-feira 10/06", "Sábado 11/06", "Domingo 12/06", "Segunda-feira 13/06", "Terça-feira 14/06", "Quarta-feira 15/06", "Quinta-feira 16/06", "Sexta-feira 17/06", "Sábado 18/06", ]
    
    private let service: ForecastService = ForecastService()
    
    var forecast: [Hour] = []
    
    public func getForecastRequest() {
        service.getForecast { success, error in
            if let success = success {
                self.forecast = success
                self.delegate?.success()
            } else {
                self.delegate?.error()
            }
        }
    }
    
    public var forecastCount: Int {
        return 10
    }

}
