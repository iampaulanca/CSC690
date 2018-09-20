//
//  AlphanumericCesarCipher.swift
//  SpyAppTests
//
//  Created by Paul Ancajima on 9/20/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import XCTest
@testable import SpyApp

class AlphanumericCesarCipherTests: XCTestCase {
    
    func test_ZmapsTo0() {
        let cipher = AlphanumericCesarCipher()
        let plainttext = "Z"
        let result = cipher.encode(plainttext, secret: "1")
        
        XCTAssertEqual(result, "0")
        
    }
    func test_aMapsToA() {
        let cipher = AlphanumericCesarCipher()
        let plainttext = "a"
        let result = cipher.encode(plainttext, secret: "0")
        XCTAssertEqual(result, "A")
        
    }
    func test_9MapsToA() {
        let cipher = AlphanumericCesarCipher()
        let plainttext = "9"
        let result = cipher.encode(plainttext, secret: "1")
        XCTAssertEqual(result, "A")
    }
    func test_encodeWillBeWithin36CharLimit(){
        let cipher = AlphanumericCesarCipher()
        let plaintext = "a"
        let result = cipher.encode(plaintext, secret: "36")
        XCTAssertEqual(result, "A")
    }
    func test_decrpytWillBeWithin36CharLimit(){
        let cipher = AlphanumericCesarCipher()
        let plaintext = "a"
        let result = cipher.decrypt(plaintext, secret: "36")
        XCTAssertEqual(result, "A")
    }
    
}
