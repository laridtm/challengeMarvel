import Foundation
import CryptoKit

struct Authentication {
    static func formatUrlWithCredentials(url: String) -> String {
        let publicKey = "505ea7d44709a9e85ef32c69a56cb2c7"
        let privateKey = "72f8aaf9a1999ccc0a4e2bbe277db8dba3b98135"
        
        let ts = Date().timeIntervalSince1970
        let hashData = "\(ts)\(privateKey)\(publicKey)"
        let hash = MD5(string: hashData)
        
        return "\(url)?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
