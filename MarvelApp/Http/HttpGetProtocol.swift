//
//  HttpGetProtocol.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import Foundation

public protocol HttpGetProtocol {
    func get(url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
