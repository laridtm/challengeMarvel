//
//  AuthenticationTests.swift
//  challangeMarvelTests
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import XCTest

class AuthenticationTests: XCTestCase {

    var authentication: Authentication?
    
    override func setUp() {
        super.setUp()
        authentication = Authentication()
    }
    
    override func tearDown() {
        super.tearDown()
        authentication = nil
    }

    func testMd5Algorithm() {
        let hash = "2c3e9759605f5af4cec4035f0eb3078c"
        let hashResult = authentication?.MD5(string: "myPrivateKey")
        XCTAssertEqual(hash, hashResult)
    }
}
