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
