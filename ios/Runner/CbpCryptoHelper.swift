//
//  CbpCryptoHelper.swift
//  Runner
//
//  Created by HungNQ on 23/09/2023.
//

import UIKit
import CryptoSwift
import SwiftyRSA
import CryptoKit

extension String {
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
}

@objc open class CbpCryptoSwift: NSObject {
    
    func getPrivateKey() -> PrivateKey? {
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
        do {
            let privateKey = try PrivateKey(pemEncoded: privateKeyStr)
            return privateKey
        } catch {
            print("CryptoSwift: error: \(error)")
            return nil
        }
    }
    
    func getPublicKey() -> PublicKey? {
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
    
    @objc open func decrypt() {
        
        var strData = "WUyXET4J62fg9Lhcy6o5y/PNPrtaDmnls6jw0gvGQ3kwcln8TpiHCRKS/TErjkcAtggrdEtGqwnN\r\nRX9h2TF+YtsiWFQPSw/iObfbnECnFKaRqfT4mGTI2Ugx+4eyiNNNqmHngCM3e0OTSlrq/05OAtx+\r\nN6xqdkJY8oDQjsWSEJ0=" as NSString;
        while (strData.contains("\r\n")) {
            strData = strData.replacingOccurrences(of: "\r\n", with: "") as NSString
        }
        
        var strSecret = "00aSxF0MfkY804CWyVWBgzfR02MCAn3XQVI9FVXIJqUurs76Mg/9Euuh0xm3kr0I9FZtS2sGFFaO\r\n/emF6lXCMq4E41ob9t5jcl9yYlji4b431nilq2sEl3+LHzQ9IrJhy6KmVRERcHaqvlZ7n5JN5yj1\r\nRYNSrobyyHNToJ2UZo8+AilIsKOABUhCBZCWt+SzPz9U3a5i1rRcumn68pTw4A9argUb+33hmX9A\r\n0kbvZXZmRMgMBX+IkgRZHDPouzZ3IMToaaQTYegrLyrvLbsNbdoxyVePEoQo6ByuRm4xkQZDIzS1\r\n4DRyW+A/pwe39v9hNP0tOMqRQkWczF4pZFSurg==" as NSString
        while (strSecret.contains("\r\n")) {
            strSecret = strSecret.replacingOccurrences(of: "\r\n", with: "") as NSString
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
                    let strDataDecrypted = String(data: Data(bytes: decrypted, count: decrypted.count), encoding: .utf8)! as NSString
                    let tag = gcm.authenticationTag
                    print("strDataDecrypted: \(strDataDecrypted), tag: \(tag)")
                } catch {
                    // failed
                }
                
                //verify signature
                let clear = try ClearMessage(string: strSignature as String, using: .utf8)
                let signature = try Signature(base64Encoded: strData as String)
                let isSuccessful = try clear.verify(with: cbpMbibPublicKey, signature: signature, digestType: .sha256)
                print("signature verify: \(isSuccessful)")
                //----------------
            }
        } catch {
            print("CryptoSwift: error: \(error)")
        }
    }
    
    @objc open func encrypt() {
        do {
            
            var strData = ""
            var strSecret = ""
            var strSignature = ""
            
            guard let privateKey = self.getPrivateKey() else {
                return
            }
            guard let publicKey = self.getPublicKey() else {
                return
            }
            guard let cbpMbibPublicKey = self.getCbpMbibPublicKey() else {
                return
            }
            
            
            let strRequest = "{\"username\":\"testusr1\"}" //TODO: fill request
            
            //encrypt data
            let key = SymmetricKey(size: .bits256)
            let ivStr = "AAAAAAAAAAAAAAAAAAAAAA==" //TODO: fill iv
            let nonce = try AES.GCM.Nonce(data: Data(base64Encoded: ivStr)!)
            let sealedBox = try AES.GCM.seal(strRequest.data(using: .utf8)!, using: key, nonce: nonce)
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
            var result = SecKeyCreateEncryptedData(cbpMbibPublicKey.reference, .rsaEncryptionRaw, strSecretData as! CFData, error) as? Data
            if let result = result {
                strSecret = result.base64EncodedString()
                strSecret = strSecret.split(by: 76).joined(separator: "\r\n")
                print("strSecret = \(strSecret)")
            }
            //---------
            
            
            //signature
            let clear = try ClearMessage(string: strData, using: .utf8)
            let signature = try clear.signed(with: privateKey, digestType: .sha256)
            let data = signature.data
            strSignature = signature.base64String
            //----------
            
            let requestData = [
                "data": strData,
                "secret": strSecret,
                "strSignature": strSignature,
            ]
//            print("stringify: \(CryptoSwift.stringify(json: requestData))")
            
        } catch {
            print("error: \(error)")
        }
    }
    
    static func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
          options = JSONSerialization.WritingOptions.prettyPrinted
        }

        do {
          let data = try JSONSerialization.data(withJSONObject: json, options: options)
          if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
          }
        } catch {
          print(error)
        }

        return ""
    }
    
    
//    // Generate one-time AES-256 key and IV buffer
//    KeyGenerator keyGen = KeyGenerator.getInstance("AES");
//    keyGen.init(256);
//    SecretKey oneTimeAESKey = keyGen.generateKey();
//    byte[] ivBuffer = new byte[16];
    
    // Returned value will be used for data field in message body
//    private static String aesEncryption(String requestMessage, Key oneTimeAESKey, byte[] ivBuffer) {
//        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
//        cipher.init(1, oneTimeAESKey, new GCMParameterSpec(128, ivBuffer));
//        byte[] encryptedText = cipher.doFinal(requestMessage.getBytes(StandardCharsets.UTF_8));
//        return Base64.getMimeEncoder().encodeToString(encryptedText);
//    }
    
    // Returned value will be used for secret field in message body
//    private static String rsaEncryption(SecretKey oneTimeAESKey, byte[] ivBuffer, Key cbpMbibRSAPublicKey) {
//        String encodedKey = Base64.getEncoder().encodeToString(oneTimeAESKey.getEncoded());
//        String encodedIV = Base64.getEncoder().encodeToString(ivBuffer);
//        String keyAndIv = encodedIV + "|" + encodedKey;
//        Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
//        cipher.init(1, cbpMbibRSAPublicKey, new OAEPParameterSpec("SHA-256", "MGF1",
//        MGF1ParameterSpec.SHA256, PSource.PSpecified.DEFAULT));
//        byte[] encryptedText = cipher.doFinal(keyAndIv.getBytes(StandardCharsets.UTF_8));
//        return Base64.getMimeEncoder().encodeToString(encryptedText);
//    }
    
    // Request message object with header object and body object
    // Returned value will be used for signature field
//    private static String getSignature(String requestMessage, PrivateKey clientRSAPrivateKey) throws
//    Exception {
//        Signature signatureInstance = Signature.getInstance("SHA256withRSA");
//        signatureInstance.initSign(clientRSAPrivateKey);
//        signatureInstance.update(requestMessage.getBytes(StandardCharsets.UTF_8));
//        byte[] signature = signatureInstance.sign();
//        return Base64.getEncoder().encodeToString(signature);
//    }
    
//    private static Boolean verifySignature(String responseMessage, String signature, PublicKey
//    cbpMbibRSAPublicKey) {
//        Signature signatureInstance = Signature.getInstance("SHA256withRSA");
//        signatureInstance.initVerify(cbpMbibRSAPublicKey);
//        signatureInstance.update(responseMessage.getBytes(StandardCharsets.UTF_8));
//        Boolean verified = signatureInstance.verify(Base64.getMimeDecoder().decode(signature.getBytes()));
//        return verified;
//    }
    
}
