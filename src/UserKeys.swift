import Foundation
import CryptoKit

class CryptoKeys: ObservableObject {
    @Published var privateKey = Curve25519.Signing.PrivateKey()
    @Published var publicKey = Curve25519.Signing.PrivateKey().publicKey
    
    var privateKeyBase58: String {
        base58Encode(privateKey.rawRepresentation)
    }
    
    var publicKeyBase58: String {
        base58Encode(publicKey.rawRepresentation)
    }
    
    @Published var privateKeyBase58Value = ""
    @Published var publicKeyBase58Value = ""
    
    
    init() {
        privateKeyBase58Value = base58Encode(privateKey.rawRepresentation)
        publicKeyBase58Value = base58Encode(publicKey.rawRepresentation)
    }
    
    func generateKeys() {
        privateKey = Curve25519.Signing.PrivateKey()
        publicKey = privateKey.publicKey
        privateKeyBase58Value = base58Encode(privateKey.rawRepresentation)
        publicKeyBase58Value = base58Encode(publicKey.rawRepresentation)
    }
}
