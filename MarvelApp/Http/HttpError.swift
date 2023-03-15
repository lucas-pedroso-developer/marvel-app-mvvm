//
//  HttpError.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
    case unexpected
}
