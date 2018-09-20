import Foundation

struct CesarCipher: Cipher {

    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        var shiftBy = UInt32(secret)!
        if shiftBy > 95 {
            if shiftBy % 95 == 0 {
                shiftBy = 0
            } else {
                shiftBy = shiftBy % 95
            }
        }
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode + shiftBy
            if shiftedUnicode > 126 {
                shiftedUnicode = shiftedUnicode - 126 + 31
            }
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    func decrypt(_ encryptedString: String, secret: String) -> String {
        var decoded = ""
        var shiftBy = UInt32(secret)!
        if shiftBy > 95 {
            if shiftBy % 95 == 0 {
                shiftBy = 0
            } else {
                shiftBy = shiftBy % 95
            }
        }
        for character in encryptedString {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode - shiftBy
            shiftedUnicode = shiftedUnicode.magnitude
            if shiftedUnicode < 32 {
                shiftedUnicode = 127 - (32 - shiftedUnicode)
            }
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decoded = decoded + shiftedCharacter
        }
        return decoded
    }
    
}
