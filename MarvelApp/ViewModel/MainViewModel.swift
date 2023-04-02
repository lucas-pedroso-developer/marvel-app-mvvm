//
//  MainViewModel.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import Foundation
import Combine

public class MainViewModel {
    
    public var resultsArray: [DataList]?
    public var characterToSearch: String = ""
    public var characters: Characters?
    private var service: HttpGetProtocol
    //public init() { }
    public init(service: HttpGetProtocol) {
        self.service = service
    }
    
    public func getCharacterId(indexPath: Int) -> Int {
        if let id = self.characters?.data?.results?[indexPath].id {
            return id
        }
        return 0
    }
    
    public func getCharacterName(indexPath: Int) -> String {
        if let title = self.characters?.data?.results?[indexPath].name {
            return title
        }
        return "No name"
    }
    
    public func getImage(indexPath: Int) -> URL? {
        guard let thumbnail = self.characters?.data?.results?[indexPath].thumbnail else { return nil }
        guard let path = thumbnail.path else { return nil }
        guard let imageExtension = thumbnail.imageExtension else { return nil }
        guard let url = URL(string:  "\(path)/portrait_xlarge.\(imageExtension)") else { return nil }
        return url
    }
    
    public func get(url: URL) -> Future<Characters, HttpError> {
        return Future { promixe in
            self.service.get(url: url) { result in
                switch result {
                case .success(let data):
                    if let unwrapData = data {
                        do {
                            let results = try JSONDecoder().decode(Characters.self, from: unwrapData)
                            self.characters = results
                            promixe(.success(results))
                        } catch (_) {
                            promixe(.failure(.unexpected))
                        }
                    }
                    promixe(.failure(.unexpected))
                case .failure(let error):
                    promixe(.failure(error))
                }
            }
        }
    }
}
