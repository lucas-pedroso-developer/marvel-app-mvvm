//
//  Results.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import Foundation

public struct Results : Model {
    public var id : Int?
    public var name : String?
    public var description : String?
    public var modified : String?
    public var thumbnail : Thumbnail?
    public var resourceURI : String?
    public var comics : Comics?
    
    init(id : Int?, name : String?, description : String?, modified : String?, thumbnail : Thumbnail?, resourceURI : String?, comics : Comics?) throws {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
    }

}
