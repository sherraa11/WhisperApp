//
//  AuthentecationManager.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import Foundation
import Firebase


final class AuthentecationManager {
    var returnedverificationID : String = ""
    static let shared = AuthentecationManager()
    private init(){ }
    
    func SignUp(phoneNumber : String , cityCode : String) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        let completePhoneNumber = "+"+cityCode+phoneNumber
        print(completePhoneNumber)
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(completePhoneNumber, uiDelegate: nil) { ID, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let verificationID = ID {
                    self.returnedverificationID = verificationID
                }
            }
        
        
    }
    func Verification(returnedVerificationCode: String, typedVerificationCode: String, completion: @escaping (Bool) -> Void) {
        let credetial = PhoneAuthProvider.provider().credential(withVerificationID: returnedVerificationCode, verificationCode: typedVerificationCode)
        
        Auth.auth().signIn(with: credetial) { result, error in
            if let error = error {
                print(error.localizedDescription)
                completion(false) // Call completion with false if there's an error
                return
            }
            completion(true) // Call completion with true upon successful verification
        }
    }
}
