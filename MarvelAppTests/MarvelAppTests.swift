//
//  MarvelAppTests.swift
//  MarvelAppTests
//
//  Created by user on 04/03/23.
//

import XCTest
@testable import MarvelApp

final class MarvelAppTests: XCTestCase {

    private let urlString = "http://gateway.marvel.com/v1/public/characters?ts=1&apikey=c99a0bfa90957bf174792400a359a7dd&hash=da0e3c9ea128303172e7fe65eed2e63d"
    private let spy = HttpServiceSpy()
    private lazy var sut = MainViewModel(
        service: spy
    )
    
    func test_getMethodIsCalled() {
        sut.get(url: URL(string: urlString)!)
        XCTAssertTrue(spy.getIsCalled)
    }

}

final class HttpServiceSpy: HttpGetProtocol {
    var getIsCalled: Bool = false
    var dataToReturn: Data?
    func get(url: URL, completion: @escaping (Result<Data?, MarvelApp.HttpError>) -> Void) {
        getIsCalled = true
        completion(.success(dataToReturn))
    }
    
    
}
