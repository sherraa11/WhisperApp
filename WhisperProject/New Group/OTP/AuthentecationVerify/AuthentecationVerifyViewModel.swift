//
//  AuthentecationVerifyViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//
import SwiftUI
import Foundation
final class AuthentecationVerifyViewModel : ObservableObject {
    @Published var verificationCode : String = ""
    @Published var showHome : Bool = UserDefaults.standard.value(forKey: "showHome") as? Bool ?? false
    @Published var showCreateAccount : Bool = false
    @Published var verificationCodeError : Bool = false
    @Published var isLoading : Bool = false
    
    
    func VerfiyOTP() {
        self.verificationCodeError = false
        self.isLoading = true
        AuthentecationManager.shared.Verification(typedVerificationCode: verificationCode) { success in
            if success {
                FirestoreManager.shared.checkUserIfExists { exists in
                    if exists {
                        print("user exist ")
                        self.showHome.toggle()
                    }else{
                        print("new user")
                        self.showCreateAccount.toggle()
                    }
                }
            }else {
                self.verificationCodeError = true
                print("wrong number")
            }
            self.isLoading = false
        }
        
    }
}
