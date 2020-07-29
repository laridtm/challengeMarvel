//
//  Authentication.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation
import CryptoKit

class Authentication {
    
    var publicKey: String = "505ea7d44709a9e85ef32c69a56cb2c7"
    var privateKey: String = "72f8aaf9a1999ccc0a4e2bbe277db8dba3b98135"
    
    func addCredentials(url: String) -> String {
        let ts = Date().timeIntervalSince1970
        let hashData = "\(ts)\(privateKey)\(publicKey)"
        let hash = MD5(string: hashData)
        
        return "\(url)?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
