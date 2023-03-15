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
    
    public init() { }
    
    public func getCharacterId(indexPath: Int) -> Int {
        if let id = self.characters?.data?.results![indexPath].id {
            return id
        }
        return 0
    }
    
    public func getCharacterName(indexPath: Int) -> String {
        if let title = self.characters?.data?.results![indexPath].name {
            return title
        }
        return "No name"
    }
    
    public func getImage(indexPath: Int) -> URL? {
        if let thumbnail = self.characters?.data?.results![indexPath].thumbnail {
            print("\(thumbnail.path!)/portrait_xlarge.\(thumbnail.imageExtension!)")
            if let url = URL(string:  "\(thumbnail.path!)/portrait_xlarge.\(thumbnail.imageExtension!)") {
                return url
            }
        }
        return nil
    }
    
    public func get(url: URL) -> Future<Characters, Error> {
        return Future { promixe in
            HttpService.shared.get(url: url) { result in
                switch result {
                case .success(let data):
                    if data != nil {
                        do {
                            let results = try JSONDecoder().decode(Characters.self, from: data!)
                            if self.characters == nil {
                                self.characters = results
                                promixe(.success(self.characters!))
                                //self.callSuccessObserver()
                            } else {
                                self.characters?.data?.results!.append(contentsOf: (results.data?.results)!)
                                //self.callSuccessObserver()
                                promixe(.success(self.characters!))
                            }
                        } catch(let error) {
                            //self.callErrorObserver()
                            promixe(.failure(error))
                        }
                    } else {
                        print("error")
                        //promixe(.failure(<#Error#>))
                    }
                case .failure(let error):
                    promixe(.failure(error))
                }
            }
        }
    }
}
