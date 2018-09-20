//
//  AlphanumericCesarCipher.swift
//  SpyApp
//
//  Created by Paul Ancajima on 9/3/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import Foundation


struct AlphanumericCesarCipher: Cipher {
    
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        var shiftBy = UInt32(secret)!
        if shiftBy > 36 {
            if shiftBy % 36 == 0 {
                shiftBy = 0
            } else {
                shiftBy %= 36
            }
        }
        var thisIsEncryption = true
        
        //Dec.: 48-57 is [0-9],  65-90 is [A-Z], 97-122 is [a-z]
        for character in plaintext {
            //get unicode value from plaintext's character
            let unicode = character.unicodeScalars.first!.value
            //shift unicode by "secret" value and get shifted character's unicode value
            var shiftedUnicode = unicode + shiftBy
            shiftedUnicode = getCharacter(unicode: unicode, shiftedUnicode: shiftedUnicode, thisIsEncryption)
            //get the character of the shiftedUnicode
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            //change character to upper case
            encoded = encoded + shiftedCharacter.uppercased()
        }
        return encoded
    }
    
    func decrypt(_ encryptedString: String, secret: String) -> String {
        var encoded = ""
        var shiftBy = UInt32(secret)!
        if shiftBy > 36 {
            if shiftBy % 36 == 0 {
                shiftBy = 0
            } else {
                shiftBy %= 36
            }
        }
        var thisIsEncryption = false
        //Dec.: 48-57 is [0-9],  65-90 is [A-Z], 97-122 is [a-z]
        for character in encryptedString {
            //get unicode value from plaintext's character
            let unicode = character.unicodeScalars.first!.value
            //shift unicode by "secret" value and get shifted character's unicode value
            var shiftedUnicode = unicode - shiftBy
            shiftedUnicode = getCharacter(unicode: unicode, shiftedUnicode: shiftedUnicode, thisIsEncryption)
            //get the character of the shiftedUnicode
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            //change character to upper case
            encoded = encoded + shiftedCharacter.uppercased()
        }
        return encoded
    }
    
    func getCharacter(unicode: UInt32, shiftedUnicode: UInt32, _ encryption: Bool) -> UInt32 {
        
        var unicodeIsDigit = false
        var unicodeIsLowerCase = false
        var unicodeIsUpperCase = false
        
        //newShiftedUnicode can be shifted up OR down
        var newUnicode = unicode
        var newShiftedUnicode = shiftedUnicode
        
        //if unicode is lower case alphabet convert it to uppercase
        unicodeIsLowerCase = (newUnicode >= 97 && newUnicode <= 122)
        if unicodeIsLowerCase {
            //if unicode is a lower case alphabet convert it to an upper case alphabet
            newUnicode = unicode - 32
            newShiftedUnicode = shiftedUnicode - 32
        }
        
        //if shifted unicode is beyond "Z" go to "0" or if shifted unicode is beyond "9" go to "A"
        unicodeIsDigit = (newUnicode >= 48 && newUnicode <= 57) //if unicode is digit it is between 48 - 57 (0-9)
        if unicodeIsDigit {
            //if user wants to encrypt
            if encryption {
                //if shifted Unicode is greater than unicode representing "9" then wrap remainder to "A"
                if newShiftedUnicode > 57 {
                    //get new remainder for shifting
                    newShiftedUnicode = (newShiftedUnicode - 57) + 64
                    //recurse
                    newShiftedUnicode = getCharacter(unicode: 65, shiftedUnicode: newShiftedUnicode, encryption)
                }
                //else user wants to decrypt
            } else {
                //if shiftedUnicode is less than unicode representing "0" then wrap remainder to "Z"
                //see if the newShiftedUnicode is outside of digit unicode bounds (48-57)
                if newShiftedUnicode < 48 {
                    //if it is out of bounds get the remainder recurse to the "Z" and update newShiftedUnicode
                    newShiftedUnicode = 91 - (48 - newShiftedUnicode)
                    //recurse
                    newShiftedUnicode = getCharacter(unicode: 90, shiftedUnicode: newShiftedUnicode, encryption)
                }
            }
        }
        
        //if unicode is upper case alphabet
        unicodeIsUpperCase = (newUnicode >= 65 && newUnicode <= 90)
        if unicodeIsUpperCase {
            if encryption {
                //if shiftedUnicode is greater than unicode representing "Z" then map to "0"
                if newShiftedUnicode > 90 {
                    //get new remainder
                    newShiftedUnicode = (newShiftedUnicode - 90) + 47
                    //recurse
                    newShiftedUnicode = getCharacter(unicode: 48, shiftedUnicode: newShiftedUnicode, encryption)
                }
            } else {
                if newShiftedUnicode < 65 {
                    //get new remainder
                    newShiftedUnicode = 58 - (65 - newShiftedUnicode)
                    //recurse
                    newShiftedUnicode = getCharacter(unicode: 57, shiftedUnicode: newShiftedUnicode, encryption)
                }
            }
        }
        
        return newShiftedUnicode
    }
    
    
}
