//
//  DataList.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import Foundation

public struct DataList: Model {
    public var offset: Int?
    public var limit: Int?
    public var total: Int?
    public var count: Int?
    public var results: [Results]?

    init(offset: Int?, limit: Int?, total: Int?, count: Int?, results: [Results]?) throws {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }

}
