//
//  CesarCipherTests.swift
//  SpyAppTests
//
//  Created by Paul Ancajima on 9/20/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import XCTest
@testable import SpyApp

class CesarCipherTests: XCTestCase {
    
    func test_oneCharWillMapToItSelf() {
        let cipher = CesarCipher()
        let plaintext = "a"
        let result = cipher.encode(plaintext, secret: "0")
        XCTAssertEqual(plaintext, result)
    }
    
    func test_encodeWillBeWithin95CharLimit(){
        let cipher = CesarCipher()
        let plaintext = "a"
        let result = cipher.encode(plaintext, secret: "95")
        XCTAssertEqual(plaintext, result)
    }
    
    func test_encodeWillBeWithin95CharLimitLargeNumber(){
        let cipher = CesarCipher()
        let plaintext = "a"
        //95*10 = 950
        let result2 = cipher.encode(plaintext, secret: "95")
        let result = cipher.encode(plaintext, secret: "950")
        XCTAssertEqual(result2, result)
    }
    
    func test_decrpytWillBeWithin95CharLimit(){
        let cipher = CesarCipher()
        let plaintext = "a"
        let result = cipher.decrypt(plaintext, secret: "95")
        XCTAssertEqual(plaintext, result)
    }
   
    
}
