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
    var optionalBool : Bool?
    let verificationID = AuthentecationManager.shared.returnedverificationID
    
    func Verfiy(){
        if !verificationCode.isEmpty{
            AuthentecationManager.shared.Verification(returnedVerificationCode:AuthentecationManager.shared.returnedverificationID , typedVerificationCode: verificationCode) { sucess in
                if sucess {
                    FirestoreManager.shared.CheckUser { exists in
                        if exists {
                            print("user exist ")
                            self.showHome.toggle()
                        }else{
                            print("new user")
                            self.showCreateAccount.toggle()
                        }
                    }
                }else {
                    print("wrong number")
                }
            }
        }
    } 
}
