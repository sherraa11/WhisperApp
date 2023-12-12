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
    @Published var isLoading : Bool = false
    @Published var cityCodeError : Bool = false
    @Published var phoneNumberError : Bool = false
    
    
    func Singup() {
        cityCodeError = cityCode.isEmpty
        phoneNumberError = true
        if cityCode != "" && (phoneNumber.count == 11 || phoneNumber.count == 10){
            cityCodeError = false
            phoneNumberError = false
            isLoading.toggle()
            
            let truePhoneNumber = {
                if self.phoneNumber.count == 11 {
                    return String(self.phoneNumber.dropFirst())
                }
                return self.phoneNumber
            }
            AuthentecationManager.shared.SignUp(phoneNumber: truePhoneNumber() , cityCode: cityCode ) { error in
                if let error {
                    self.phoneNumberError = true
                    print(error)
                }else {
                    self.showVerify.toggle()
                }
                self.isLoading.toggle()
            }
        }
    }
}
