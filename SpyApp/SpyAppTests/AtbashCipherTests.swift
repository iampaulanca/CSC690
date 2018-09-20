//
//  AtbashCipherTests.swift
//  SpyAppTests
//
//  Created by Paul Ancajima on 9/20/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import XCTest
@testable import SpyApp

class AtbashCipherTests: XCTestCase {
    
    func test_aToZ() {
        let cipher = AtbashCipher()
        let plaintext = "a"
        let result = cipher.encode(plaintext, secret: "0")
        XCTAssertEqual(result, "Z")
    }
    
    func test_zToA() {
        let cipher = AtbashCipher()
        let plaintext = "z"
        let result = cipher.encode(plaintext, secret: "0")
        XCTAssertEqual(result, "A")
    }
    
}
