//
//  CharacterDetailsWorkerTests.swift
//  challangeMarvelTests
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import XCTest

class CharacterDetailsWorkerTests: XCTestCase {
    
    var worker: CharacterDetailsWorkerProtocol?
    var comics: [Comic]?
    
    override func setUp() {
        super.setUp()
        
        worker = CharacterDetailsWorker()
        let json = """
                {
                    "code": 200,
                    "data": {
                        "results": [
                            {
                                "id": 21366,
                                "title": "Avengers: The Initiative (2007) #14",
                                "thumbnail": {
                                    "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/60/58dbce634ea70",
                                    "extension": "jpg"
                                }
                            },
                            {
                                "id": 16244,
                                "title": "Cap Transport (2005) #5",
                                "thumbnail": {
                                    "path": "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                                    "extension": "jpg"
                                }
                            },
                            {
                                "id": 16236,
                                "title": "Cap Transport (2005) #16",
                                "thumbnail": {
                                    "path": "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                                    "extension": "jpg"
                                },
                            }
                        ]
                    }
                }
                """.data(using: .utf8)
        
        comics = worker?.decode(data: json!)
    }
    
    override func tearDown() {
        super.tearDown()
        worker = nil
        comics = nil
    }
    
    func testIfTheDecoderWasSuccessful() {
        XCTAssertEqual(comics!.count, 3)
    }
}
