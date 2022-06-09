//
//  GenericService.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 09/06/22.
//

import Foundation

protocol GenericService: AnyObject {
    typealias completion <T> = (_ result: T, _ failure: Error?) -> Void
}

enum Error: Swift.Error {
    case errorDescription(message: String, error: Swift.Error? = nil)
}
