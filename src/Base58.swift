import Foundation

let alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"

func base58Encode(_ data: Data) -> String {
    var num = Data(repeating: 0, count: 1) + data
    var encoded = ""
    while num != Data() {
        var quotient = Data()
        var remainder = 0
        for byte in num {
            let dividend = (Int(remainder) << 8) + Int(byte)
            let quotientByte = dividend / 58
            remainder = dividend % 58
            if quotientByte > 0 || !quotient.isEmpty {
                quotient.append(UInt8(quotientByte))
            }
        }
        let charIndex = alphabet.index(alphabet.startIndex, offsetBy: remainder)
        encoded = String(alphabet[charIndex]) + encoded
        num = quotient
    }
    for byte in data {
        if byte != 0 {
            break
        }
        encoded = String(alphabet[alphabet.startIndex]) + encoded
    }
    return encoded
}
