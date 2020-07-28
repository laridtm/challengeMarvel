//
//  challangeMarvelTests.swift
//  challangeMarvelTests
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import XCTest
@testable import challangeMarvel

class CharactersListWorkerTests: XCTestCase {
    
    var worker: CharactersListWorkerProtocol?
    var characters: [Character]?
    
    override func setUp() {
        super.setUp()
        
        worker = CharactersListWorker()
        let json = """
            {
                "code": 200,
                "data": {
                    "results": [
                        {
                            "id": 1011334,
                            "name": "3-D Man",
                            "thumbnail": {
                                "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                                "extension": "jpg"
                            }
                        },
                        {
                            "id": 1011334,
                            "name": "A.I.M.",
                            "thumbnail": {
                                "path": "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec",
                                "extension": "jpg"
                            }
                        },
                        {
                            "id": 1011334,
                            "name": "A-Bomb (HAS)",
                            "thumbnail": {
                                "path": "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                                "extension": "jpg"
                            }
                        }
                    ]
                }
            }
            """.data(using: .utf8)
        
        characters = worker?.decode(data: json!)
    }
    
    override func tearDown() {
        super.tearDown()
        worker = nil
        characters = nil
    }
    
    func testIfTheDecoderWasSuccessful() {
        XCTAssertEqual(characters!.count, 3)
    }
}
