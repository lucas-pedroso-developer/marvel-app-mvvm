//
//  Model.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import Foundation

public protocol Model: Encodable, Decodable, Equatable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
