//
//  HttpService.swift
//  MarvelApp
//
//  Created by user on 04/03/23.
//

import Foundation
import Alamofire
import Combine

public class HttpService: HttpGetProtocol {
    
    private let session : Session
    //public static let shared = HttpService()
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func get(url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        session.request(url, method: .get, encoding: JSONEncoding.default).responseData { dataResponse in
            print(dataResponse)
            guard let statusCode = dataResponse.response?.statusCode else { return
                completion(.failure(.noConnectivity)) }
            switch dataResponse.result {
                case .failure: completion(.failure(.noConnectivity))
                case .success(let data):
                    switch statusCode {
                    case 204:
                        completion(.success(nil))
                    case 200...299:
                        completion(.success(data))
                    case 401:
                        completion(.failure(.unauthorized))
                    case 403:
                        completion(.failure(.forbidden))
                    case 400...499:
                        completion(.failure(.badRequest))
                    case 500...599:
                        completion(.failure(.serverError))
                    default:
                        completion(.failure(.noConnectivity))
                    }
            }
        }
    }
}
