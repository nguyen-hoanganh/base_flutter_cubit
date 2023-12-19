//
//  CbpCryptoConfig.swift
//  Runner
//
//  Created by HungNQ on 23/09/2023.
//

import Foundation
import Flutter
import CryptoSwift
import SwiftyRSA
import CryptoKit
import CommonCrypto



extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}

enum SignatureErr: Error {
    case err
    case algorithmNotSupported
    case signatureError
    // Add more error cases as needed
}

class CbpCryptoConfig: NSObject{
    var flutterResult: FlutterResult?
    var rootVC: FlutterViewController?
    
    
    public func setMethodCallHandler(controller: FlutterViewController) {
        let METHOD_CHANNEL_NAME = "cbp_rsa"
        let vtapChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
        
        vtapChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case "aesEncryption":
                guard let agrs = call.arguments as? [Any] else { return }
                self.rootVC = controller
                self.flutterResult = result
                let dataToEncrypt = agrs[0]
                self.aesEncryption(dataToEncrypt: dataToEncrypt as! String, result: result)
            case "getSignature":
                guard let agrs = call.arguments as? [Any] else { return }
                self.rootVC = controller
                self.flutterResult = result
                let dataToEncrypt = agrs[0]
                self.getSignature(plainTextMessage: dataToEncrypt as! String, result: result)
            case "aesDecryption":
                guard let agrs = call.arguments as? [Any] else { return }
                self.rootVC = controller
                self.flutterResult = result
                let options = agrs[0]
                self.aesDecryption(options: options as! NSDictionary, resultFlutter: result)
            case "publicKeyData":
                let publicKey = self.getPublicKeyOrigin()
                 result(publicKey)
             case "privateKeyData":
                 let privateKey = self.getPrivateKeyOrigin()
                 result(privateKey)
            default:
                result(FlutterMethodNotImplemented)
            }
        })
    }
    
    func getPrivateKeyOrigin() -> String {
        let privateKeyOrigin = """
        -----BEGIN PRIVATE KEY-----
        MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQDpwNOY69lzDiVf
        pS4cZpiHqAgpnJ92oQ4nvtZeAcwXIcx/7+Ak5YpE+KS6W++HbSEWE0YW3xTUh7di
        hW9Mfre3e2WwtBPhinVKOoGJEzz7+ADXgXnDYvU4IYUEqv9fgdA2QoVK+/3EkFjS
        TkIlzlR5dGnQ6z2GHLXYTKCyCLY+OD2147NL9nXKhM5436zLj63wnNkYw27qpeCy
        oMFBoA7On9P4Vri8QChNVOpNbsKnhRPdOZBtUO9UGbr8Z14qeKBDJ6CCDYvJrRpu
        WLtPBuDc05rlmHD8nX87efO4ZQMJgVKAyXWKevE0JGwShM+3nD9Nm3PnIq33pGGw
        yy4TlFQZAgMBAAECggEBAL/2Ns7SgNTXvSF6yQ9RwdlFyM5DbUFCqhlBw1GYMD6e
        5w35tB0Y1CAoAT952I9is1UpptmJgdW3ToZ+BhTPy5fGopAmkl0aE5BN06r6PY6+
        8BIKpjAqyC68eDyJIQcR2Cd3IXee0Zvm3sp2siPR+dV0IKINTY0hbsSeySjrtp4I
        h+1Lx0X4u0HPDF+rBTp8OzBnKtOCq8LdP2/d5veg6hQhEnh9FdkhYfjXWFPTuGmR
        gwvVPvMrqcrfBagPcajK53Qgj3astR9O3wFYkDUxB46ZNZxj4UgAUR5IBpjgIBhR
        4aLvnuO0PG0aQ6Os6uBRFWKaElo6IEwUWJqPCGuKi3ECgYEA+Nwl/xiAaY+lS2LY
        y5q9oWv5VO/98CBC6uOMU0kgmZPV4e15TLTP9ZIMe5SqCn4U3Il1KGBj505giINo
        8fVPjx2wF9qYyktd1alJX2/DqZO4BOVNudx99lhSIk/KRTQ45jCmD+bXgz10KEfu
        Sz1suQ2KRgbfgO7TcDQe//1JADMCgYEA8HW4gcqzqxtzFt69NInDDFMor4H1xMgF
        wg1FS3zTstnkOkJZFRZDc89s9SWn/Qf/9SDGbdUgzCwdYzj73W67SJgGVCn57CaF
        nbKzmzPd9Dgmz33DhmFlJZ1EJORgjeJwlBfj6pRr5BKznCQCYowgsdw4HyXvS6zq
        aphbkfG/3oMCgYEAodDUTBksdndW7bvqaAnIQEwrJdWfcyInIQCw3/7u2a3NJ0j4
        1K3Fg1JiF4FFR+lPu08OBSEYFPFbx6ha9umhv9d4Byq2quNyslmPQiU0PvG0eEp5
        zd7XcPVhArqLNZCNZvA/KpvZipbNDtwm0HmyVmm9fWc+sWGZzp21gpK5gw0CgYEA
        40BORJO+Y3qItVeCdxGvPYmmDOCE1hm3n2KNV788D25vjEPCDvTAgMXLEpApCDC0
        TQVRouFmoq8agviKyAXrh7rtWENniDAL3TLTHV3SaQlcXIJd9DU9s2PC0B7pxY34
        mW1OoBbvNFgcWPeLLXmDOLSIcZ+XXOypil49RFu12mMCgYEAzApBuueHzCgf8drB
        +jtCYUM/mDEasN9TR7y9w+fmnxGBxzWmPGlQ+Pz7I3PxMw+WUROztIs1nKgH7pDm
        d8cbfwv6MhpB3CEERcIGBdZMlgrWUHIL91yNtesIiphDASCZXXj/daFnO3PLEHXc
        RDsPu1B3xKoqSessNJSeynmbn8M=
        -----END PRIVATE KEY-----
        """
        let privateKeyStr = privateKeyOrigin
            .replacingOccurrences(of: "-----BEGIN PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "-----END PRIVATE KEY-----", with: "")
            .split(separator: "\n").joined()
       return privateKeyStr
    }
    
    func getPrivateKey() -> PrivateKey? {
        let privateKeyStr = self.getPrivateKeyOrigin()
            do {
                let privateKey = try PrivateKey(pemEncoded: privateKeyStr)
                return privateKey
            } catch {
                print("CryptoSwift: error: \(error)")
                return nil
            }
    }
    
    func getPublicKeyOrigin() -> String {
        let publicKeyOrigin = """
        -----BEGIN PUBLIC KEY-----
        MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6cDTmOvZcw4lX6UuHGaY
        h6gIKZyfdqEOJ77WXgHMFyHMf+/gJOWKRPikulvvh20hFhNGFt8U1Ie3YoVvTH63
        t3tlsLQT4Yp1SjqBiRM8+/gA14F5w2L1OCGFBKr/X4HQNkKFSvv9xJBY0k5CJc5U
        eXRp0Os9hhy12Eygsgi2Pjg9teOzS/Z1yoTOeN+sy4+t8JzZGMNu6qXgsqDBQaAO
        zp/T+Fa4vEAoTVTqTW7Cp4UT3TmQbVDvVBm6/GdeKnigQyeggg2Lya0abli7Twbg
        3NOa5Zhw/J1/O3nzuGUDCYFSgMl1inrxNCRsEoTPt5w/TZtz5yKt96RhsMsuE5RU
        GQIDAQAB
        -----END PUBLIC KEY-----
        """
        let publicKeyStr = publicKeyOrigin
            .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----END PUBLIC KEY-----", with: "")
            .split(separator: "\n").joined()
    
            return publicKeyStr
    }
    
    func getPublicKey() -> PublicKey? {
       
        let publicKeyStr = self.getPublicKeyOrigin()
        do {
            let publicKey = try PublicKey(pemEncoded: publicKeyStr)
            return publicKey
        } catch {
            print("CryptoSwift: error: \(error)")
            return nil
        }
    }
    
    func getCbpMbibPublicKey() -> PublicKey? {
        let publicKeyOrigin = """
        -----BEGIN PUBLIC KEY-----
        MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAycewBxVsn0hv4SLXo4t6
        0A8NWBSH6mdR2Fp6pL8uD+vU8gYJHENoL7kkzgBZwU6PlydVRG7hstluXUqiqtft
        xcSpA91xq3H+peKw4qJSnfKwiX4sgMtMu7Cqdq7kxQDCqTV1Zhv4gcs95yWiSJJT
        2dQCFxOJbLbrp9mo5QtAsFfrc1UwQX0CIRzFvcQD/wypZFN08Cpx+neuYSTuAE0l
        Rb2p2zgFjg3Tn9FaViB3IOxFHol/uwzeoSvagWTEq6FSABzeFQs77Gn+YZjpqvE1
        8wKWX2Yg/IZeLrjqIqq58eizS37yF+c+t6gZO8qoQb6NHqf987+/Avxq8WcjvI9V
        YQIDAQAB
        -----END PUBLIC KEY-----
        """
        let publicKeyStr = publicKeyOrigin
            .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----END PUBLIC KEY-----", with: "")
            .split(separator: "\n").joined()
        
        do {
            let publicKey = try PublicKey(pemEncoded: publicKeyStr)
            return publicKey
        } catch {
            print("CryptoSwift: error: \(error)")
            return nil
        }
    }
    
    @objc private func aesDecryption(options: NSDictionary, resultFlutter: @escaping FlutterResult) {
        
        var strData = ""
        var strSecret = ""

        if let dataMapScan = options as? [String: String],
           let data = dataMapScan["data"],
           let sec = dataMapScan["secret"] {
            strData = data
            strSecret = sec
        }
        
        
        while (strData.contains("\r\n")) {
            strData = strData.replacingOccurrences(of: "\r\n", with: "")
        }
        
        while (strSecret.contains("\r\n")) {
            strSecret = strSecret.replacingOccurrences(of: "\r\n", with: "")
        }
        
        var strSignature = "00aSxF0MfkY804CWyVWBgzfR02MCAn3XQVI9FVXIJqUurs76Mg/9Euuh0xm3kr0I9FZtS2sGFFaO\r\n/emF6lXCMq4E41ob9t5jcl9yYlji4b431nilq2sEl3+LHzQ9IrJhy6KmVRERcHaqvlZ7n5JN5yj1\r\nRYNSrobyyHNToJ2UZo8+AilIsKOABUhCBZCWt+SzPz9U3a5i1rRcumn68pTw4A9argUb+33hmX9A\r\n0kbvZXZmRMgMBX+IkgRZHDPouzZ3IMToaaQTYegrLyrvLbsNbdoxyVePEoQo6ByuRm4xkQZDIzS1\r\n4DRyW+A/pwe39v9hNP0tOMqRQkWczF4pZFSurg==" as NSString
        
        
        while (strSignature.contains("\r\n")) {
            strSignature = strSignature.replacingOccurrences(of: "\r\n", with: "") as NSString
        }
        
        do {
            guard let privateKey = self.getPrivateKey() else {
                return
            }
            guard let publicKey = self.getPublicKey() else {
                return
            }
            guard let cbpMbibPublicKey = self.getCbpMbibPublicKey() else {
                return
            }

            let padding = RsaOAEPPadding(mainDigest: OAEPDigest.SHA256, mgf1Digest: OAEPDigest.SHA256)
            var strSecretData = Data(base64Encoded: strSecret as String)
            let error:UnsafeMutablePointer<Unmanaged<CFError>?>? = nil
            var result = SecKeyCreateDecryptedData(privateKey.reference, .rsaEncryptionRaw, strSecretData as! CFData,error)
            
            var strDataDecrypted = ""
            
            if let result = result {
                let decrypted = try padding.unpad(padded: result as Data)
                let strSecretDecrypted: NSString = String(data: decrypted, encoding: .utf8)! as NSString
                print("strSecretDecrypted = \(strSecretDecrypted)")
                do {
                    // In combined mode, the authentication tag is directly appended to the encrypted message. This is usually what you want.
                    let key: Array<UInt8> = Data(base64Encoded: strSecretDecrypted.components(separatedBy: "|").last ?? "")?.bytes ?? []
                    let iv: Array<UInt8> = Data(base64Encoded: strSecretDecrypted.components(separatedBy: "|").first ?? "")?.bytes ?? []
                    let gcm = GCM(iv: iv, mode: .combined)
                    let aes = try AES(key: key, blockMode: gcm, padding: .noPadding)
                    let dataInResponseMessageBytes = Data(base64Encoded: strData as String)?.bytes ?? []
                    let decrypted = try aes.decrypt(dataInResponseMessageBytes)
                     strDataDecrypted = String(data: Data(bytes: decrypted, count: decrypted.count), encoding: .utf8)!
                    let tag = gcm.authenticationTag
                    print("strDataDecrypted: \(strDataDecrypted), tag: \(tag)")
                } catch {
                    // failed
                }
                
                resultFlutter(strDataDecrypted)
            }
        } catch {
            print("CryptoSwift: error: \(error)")
        }
    }
    
    
    @objc private func getSignature1(plainTextMessage: String, result: @escaping FlutterResult) {
        do{

            guard let privateKey = self.getPrivateKey() else {
                return
            }
            
            print("HungNq: plain text get sign: \(plainTextMessage)")
            
            guard let requestData = plainTextMessage.data(using: .utf8) else {
                throw SignatureErr.err // Define your own error type
             }

             // Create a cryptographic operation
             let algorithm: SecKeyAlgorithm = .rsaSignatureMessagePKCS1v15SHA256

            guard SecKeyIsAlgorithmSupported(privateKey.reference, .sign, algorithm) else {
                 throw  SignatureErr.err // Define your own error type
             }

             // Sign the request data using RSA with SHA-256
             var error: Unmanaged<CFError>?
            guard let signatureData = SecKeyCreateSignature(privateKey.reference, algorithm, requestData as CFData, &error) as Data? else {
                 throw  SignatureErr.err // Define your own error type
             }

             // Encode the signature data as Base64
             let signature = signatureData.base64EncodedString()


            print("HungNQ: strSignature1 \(signature)")

            result(signature)
        }catch{
            print("error: \(error)")
        }
    }
    
    
    
    @objc private func getSignature(plainTextMessage: String, result: @escaping FlutterResult) {
        do {

            var strSignature = ""

            guard let privateKey = self.getPrivateKey() else {
                return
            }
            
            //signature
            let clear = try ClearMessage(string: plainTextMessage, using: .utf8)
            let signature = try clear.signed(with: privateKey, digestType: .sha256)
            let data = signature.data
            
            strSignature = signature.base64String
            print("HugnNQ: aaaaa \(strSignature)")

            result(strSignature)
        } catch {
            print("error: \(error)")
        }
    }
    
    
    func generateAESKeyAndIV() throws -> (SymmetricKey, Data) {
        // Generate an AES key with a size of 256 bits
        let key = SymmetricKey(size: .bits256)
        
        // Generate a random IV (Initialization Vector)
        var ivBuffer = [UInt8](repeating: 0, count: 16)
        _ = SecRandomCopyBytes(kSecRandomDefault, ivBuffer.count, &ivBuffer)
        
        let ivData = Data(ivBuffer)
        
        return (key, ivData)
    }
    
    
    @objc private func aesEncryption(dataToEncrypt: String, result: @escaping FlutterResult) {
        do {

            
            var strData = ""
            var strSecret = ""
            
            
            guard let cbpMbibPublicKey = self.getCbpMbibPublicKey() else {
                return
            }
            
            
            let (oneTimeAESKey, ivData) = try generateAESKeyAndIV()
            
            let encodedIV = ivData.base64EncodedString()
            let key = oneTimeAESKey.withUnsafeBytes { body in
                Data(body).bytes
            }
            let gcm = GCM(iv: ivData.bytes, mode: .combined)
              let aes = try AES(key: key, blockMode: gcm, padding: .noPadding)
            let encrypted = try aes.encrypt(dataToEncrypt.bytes)
              let tag = gcm.authenticationTag
              strData = encrypted.toBase64()
            
            print("----- \(strData)    \(tag)")
//            print("HungNQQQQ: \(ivData.base64EncodedString())")
//            let nonce = try AES.GCM.Nonce(data: Data(base64Encoded: encodedIV)!)
//            let sealedBox = try AES.GCM.seal(dataToEncrypt.data(using: .utf8)!, using: oneTimeAESKey, nonce: nonce)
//            //aes Data
//            strData = sealedBox.ciphertext.base64EncodedString()
            
            
            
            
//            let algorithm1: CCAlgorithm = CCAlgorithm(kCCAlgorithmAES)
//            let options: CCOptions = CCOptions(kCCOptionECBMode) // Use ECB mode
//            var bytesEncrypted = 0
//            var encryptedText = Data(count: oneTimeAESKey.bitCount / 8)
//
//            // Initialize the cipher context
//            try ivData.withUnsafeBytes { ivBytes in
//                try oneTimeAESKey.withUnsafeBytes { keyBytes in
//                    let status = CCCrypt(
//                        CCOperation(kCCEncrypt),            // Encrypt operation
//                        algorithm1,                          // Algorithm (AES)
//                        options,                            // Options
//                        keyBytes.baseAddress,               // Key data
//                        keyBytes.count,                     // Key length
//                        ivBytes.baseAddress,                // IV data
//                        dataToEncrypt,                     // Input data
//                        dataToEncrypt.count,               // Input data length
//                        encryptedText.withUnsafeMutableBytes { encryptedBytes in
//                            return encryptedBytes.baseAddress // Output data
//                        },
//                        encryptedText.count,                // Output data length
//                        &bytesEncrypted
//                    )
//
////                    if status != Int32(kCCSuccess) {
////                        throw SignatureErr.err // Define your own error type
////                    }
//                }
//            }
//
//            // Encode the encrypted data as MIME base64
//            let encryptedData = encryptedText.prefix(bytesEncrypted)
//             strData = encryptedData.base64EncodedString()
            
            strData = strData.split(by: 76).joined(separator: "\r\n")
            
        
            
            //create secret key
            let keyStr = oneTimeAESKey.withUnsafeBytes { body in
                Data(body).base64EncodedString()
            }



            let keyAndIv = "\(ivData.base64EncodedString())|\(keyStr)"
            print("keyAndIv: \(keyAndIv)")

            let padding = RsaOAEPPadding(mainDigest: OAEPDigest.SHA256, mgf1Digest: OAEPDigest.SHA256)
            var strSecretData = keyAndIv.data(using: .utf8) ?? Data()
            print("strSecretData: \(strSecretData)")

            strSecretData = try padding.pad(plain: strSecretData, blockSize: 256)

            let error:UnsafeMutablePointer<Unmanaged<CFError>?>? = nil
            var resultData = SecKeyCreateEncryptedData(cbpMbibPublicKey.reference, .rsaEncryptionRaw, strSecretData as! CFData, error) as? Data
            if let resultData = resultData {
                strSecret = resultData.base64EncodedString()

                print("strSecret1 = \(strSecret)")
                strSecret = strSecret.split(by: 76).joined(separator: "\r\n")
//                print("strSecret = \(strSecret)")
            }
            
            
            // Encode the AES key and IV as Base64 strings
//
//             let encodedKey = oneTimeAESKey.withUnsafeBytes { keyBytes in
//                 Data(base64Encoded: Data(keyBytes))?.base64EncodedString()
//             }
//             let keyAndIv = "\(encodedIV)|\(encodedKey)"
//
//             // Create a cryptographic operation
//             let algorithm: SecKeyAlgorithm = .rsaEncryptionOAEPSHA256AESGCM
//             guard SecKeyIsAlgorithmSupported(cbpMbibPublicKey.reference, .encrypt, algorithm) else {
//                 throw SignatureErr.err // Define your own error type
//             }
//
//             // Encrypt the key and IV using RSA with OAEP padding and SHA-256
//             var error: Unmanaged<CFError>?
//             guard let encryptedText = SecKeyCreateEncryptedData(cbpMbibPublicKey.reference, algorithm, keyAndIv.data(using: .utf8)! as CFData, &error) as Data? else {
//                 throw SignatureErr.err// Define your own error type
//             }
//
//             // Encode the encrypted data as MIME base64
//             let encryptedString = encryptedText.base64EncodedString(options: .lineLength64Characters)

            print("HungNQ: encryptedString  \(strSecret)")
            
            var rspMap = [String: Any]()
            rspMap["data"] = strData
            rspMap["secret"] = strSecret
            
            result(rspMap)
            
        } catch {
            print("error: \(error)")
        }
    }
    
    
    
    
    @objc private func encrypt(dataToEncrypt: String, result: @escaping FlutterResult) {
        do {
            
            var strData = ""
            var strSecret = ""
            
            guard let privateKey = self.getPrivateKey() else {
                return
            }
            guard let publicKey = self.getPublicKey() else {
                return
            }
            guard let cbpMbibPublicKey = self.getCbpMbibPublicKey() else {
                return
            }
            
            
            //encrypt data
            let key = SymmetricKey(size: .bits256)
            let ivStr = "AAAAAAAAAAAAAAAAAAAAAA==" //TODO: fill iv
            let nonce = try AES.GCM.Nonce(data: Data(base64Encoded: ivStr)!)
            let sealedBox = try AES.GCM.seal(dataToEncrypt.data(using: .utf8)!, using: key, nonce: nonce)
            strData = sealedBox.ciphertext.base64EncodedString()
            strData = strData.split(by: 76).joined(separator: "\r\n")
            print("strDatar: \(strData)")
            //------------
            
            //create secret key
            let keyStr = key.withUnsafeBytes { body in
                Data(body).base64EncodedString()
            }
            let keyAndIv = "\(ivStr)|\(keyStr)"
            print("keyAndIv: \(keyAndIv)")
            
            let padding = RsaOAEPPadding(mainDigest: OAEPDigest.SHA256, mgf1Digest: OAEPDigest.SHA256)
            var strSecretData = keyAndIv.data(using: .utf8) ?? Data()
            print("strSecretData: \(strSecretData)")
            strSecretData = try padding.pad(plain: strSecretData, blockSize: 256)
            print("strSecretData: \(strSecretData)")
            let error:UnsafeMutablePointer<Unmanaged<CFError>?>? = nil
            var resultData = SecKeyCreateEncryptedData(cbpMbibPublicKey.reference, .rsaEncryptionRaw, strSecretData as! CFData, error) as? Data
            if let resultData = resultData {
                strSecret = resultData.base64EncodedString()
                strSecret = strSecret.split(by: 76).joined(separator: "\r\n")
                print("strSecret = \(strSecret)")
            }
            //---------
            
            //----------
            
            var rspMap = [String: Any]()
            rspMap["data"] = strData
            rspMap["secret"] = strSecret
            
            result(rspMap)
            
        } catch {
            print("error: \(error)")
        }
    }
    
}
