//
//  AuthentecationViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import Foundation

class AuthentecationViewModel : ObservableObject {
    @Published var phoneNumber = ""
    @Published var cityCode = ""
    @Published var showVerify : Bool = false
    
    
    func Singup() {
        guard !cityCode.isEmpty , !phoneNumber.isEmpty else {
            print("enter a phoneNumber")
            return
        }
        AuthentecationManager.shared.SignUp(phoneNumber: phoneNumber, cityCode: cityCode)
            showVerify.toggle()
    }
}
