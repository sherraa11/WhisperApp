//
//  AuthentecationManager.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//
import Foundation
import Firebase


final class AuthentecationManager {
    var returnedverificationID: String = ""
    static let shared = AuthentecationManager()
    
    private init() { }
    // Updated SignUp method with completion handler
    func SignUp(phoneNumber: String, cityCode: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        let completePhoneNumber = cityCode + phoneNumber
        PhoneAuthProvider.provider().verifyPhoneNumber(completePhoneNumber, uiDelegate: nil) { ID, error in
            if let error = error {
                print(error.localizedDescription)
                completion(error)
                return
            }
            if let verificationID = ID {
                self.returnedverificationID = verificationID
                completion(nil)
            }
        }
    }
//    it takes the OTP from signUp function and check if it ture or not
    func Verification(typedVerificationCode: String, completion: @escaping (Bool) -> Void) {
        let credetial = PhoneAuthProvider.provider().credential(withVerificationID: self.returnedverificationID, verificationCode: typedVerificationCode)
        
        Auth.auth().signIn(with: credetial) { result, error in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            completion(true)
        }
    }
}
