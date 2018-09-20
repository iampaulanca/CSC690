//
//  Cipher.swift
//  SpyApp
//
//  Created by Paul Ancajima on 9/20/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import Foundation

protocol Cipher {
    func encode(_ plaintext: String, secret: String) -> String
    func decrypt(_ encryptedString: String, secret: String) -> String
}
