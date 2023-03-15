//
//  Items.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import Foundation

public struct Items: Model {
    public var resourceURI: String?
    public var name: String?

    public init(resourceURI: String?, name: String?) {
        self.resourceURI = resourceURI
        self.name = name
    }
}
