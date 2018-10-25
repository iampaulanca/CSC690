//
//  AtbashCipher.swift
//  SpyApp
//
//  Created by Paul Ancajima on 9/20/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import Foundation

struct AtbashCipher: Cipher {
    
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        var shiftBy = UInt32(secret)!
        if shiftBy > 25{
            if shiftBy % 25 == 0 {
                shiftBy = 0
            } else {
                shiftBy = (shiftBy % 25) - 1
            }
        }
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            
            var newUnicode = unicode
            //if char is lower case convert to upper case
            if (unicode >= 97 && unicode <= 122) {
                newUnicode = unicode - 32
            }
            var shiftedUnicode = newUnicode + shiftBy
            if shiftedUnicode > 90 {
                shiftedUnicode = shiftedUnicode - 90 + 65
            }
            
            shiftedUnicode = getCharacter(unicode: shiftedUnicode)
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    func decrypt(_ encryptedString: String, secret: String) -> String {
        var decoded = ""
        var shiftBy = UInt32(secret)!
        if shiftBy > 25 {
            if shiftBy % 25 == 0 {
                shiftBy = 0
            } else {
                shiftBy = (shiftBy % 25) - 1
            }
        }
        for character in encryptedString {
            let unicode = character.unicodeScalars.first!.value
            var newUnicode = unicode
            //if char is lower case convert to upper case
            if (unicode >= 97 && unicode <= 122) {
                newUnicode = unicode - 32
            }
            var shiftedUnicode = newUnicode - shiftBy
            if shiftedUnicode < 65 {
                shiftedUnicode = 90 - (65 - shiftedUnicode)
            } else
                if shiftedUnicode < 97 && shiftedUnicode > 90 {
                    shiftedUnicode = 90 - (97 - shiftedUnicode)
            }
            shiftedUnicode = getCharacter(unicode: shiftedUnicode)
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decoded = decoded + shiftedCharacter
        }
        return decoded
    }
    
    func getCharacter(unicode: UInt32) -> UInt32{
        
        var dictionary: [UInt32: UInt32] = [:]
        for i in 0...25 {
            dictionary["A".unicodeScalars.first!.value + UInt32(i)] = "Z".unicodeScalars.first!.value - UInt32(i)
        }
        
        return dictionary[unicode]!
    }
    
}
