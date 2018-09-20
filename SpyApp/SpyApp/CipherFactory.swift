import Foundation

struct CipherFactory {

    private var ciphers: [String: Cipher] = [
        "Cesar": CesarCipher(),
        "AlphaNumeric": AlphanumericCesarCipher(),
        "Atbash": AtbashCipher(),
        "Reverse": ReverseCipher()
    ]

    func cipher(for key: String) -> Cipher {
        return ciphers[key]!
    }
}
