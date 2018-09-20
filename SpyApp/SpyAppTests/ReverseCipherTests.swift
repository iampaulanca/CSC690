//
//  ReverseCipherTests.swift
//  SpyAppTests
//
//  Created by Paul Ancajima on 9/20/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import XCTest
@testable import SpyApp

class ReverseCipherTests: XCTestCase {
    
    func test_something(){
        let cipher = ReverseCipher()
        let plaintext = "abc123"
        let result = cipher.encode(plaintext, secret: "1")
        XCTAssertEqual(result, "432dcb")
    }
    
    func test_encodeWillBeWithin95CharLimit(){
        let cipher = ReverseCipher()
        let plaintext = "abc"
        let result = cipher.encode(plaintext, secret: "95")
        XCTAssertEqual(result, "cba")
    }
    func test_decrpytWillBeWithin95CharLimit(){
        let cipher = ReverseCipher()
        let plaintext = "abc"
        let result = cipher.decrypt(plaintext, secret: "95")
        XCTAssertEqual(result, "cba")
    }
    
    func test_encodeWillBeWithin95CharLimit2(){
        let cipher = ReverseCipher()
        let plaintext = "abc"
        let result = cipher.encode(plaintext, secret: "96")
        XCTAssertEqual(result, "dcb")
    }
    
    
}
