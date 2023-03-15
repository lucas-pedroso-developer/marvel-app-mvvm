//
//  Comics.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import Foundation

public struct Comics: Model {
    public var available: Int?
    public var collectionURI: String?
    public var items: [Items]?
    public var returned: Int?

    public init(available: Int?, collectionURI: String?, items: [Items]?, returned: Int?) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }

}
