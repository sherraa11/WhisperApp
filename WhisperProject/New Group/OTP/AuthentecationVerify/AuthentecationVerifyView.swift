//
//  AuthentecationVerifyView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import SwiftUI

struct AuthentecationVerifyView: View {
    @StateObject var vm = AuthentecationVerifyViewModel()
    @Environment(\.dismiss) var dismiss
    @State  var pin: String = ""
    let pinLength = 6 // Define the length of the PIN
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack( spacing: 5){
                    HStack{
                        VStack(alignment: .leading, spacing: 5){
                            Image(systemName:"chevron.left")
                                .foregroundStyle(.black)
                                .font(.system(size: 25))
                                .fontWeight(.light)
                                .offset(y: 15)
                                .onTapGesture {
                                    self.dismiss()
                                }
                            
                            Text("OTP sent")
                                .foregroundColor(Color.black)
                                .font(.custom("Poppins", size: 20))
                                .fontWeight(.semibold)
                                .padding(.top , 45)
                            
                            Text("Enter the OTP sent to you")
                                .foregroundColor(Color.black)
                                .font(.custom("Poppins", size: 16))
                                .fontWeight(.medium)
                                .opacity(0.7)
                                .padding(.bottom , 10)
                        }.padding(.horizontal)
                        Spacer()
                    }
                    PINView
                    Spacer()
                    if vm.isLoading {
                        ProgressView()
                            .tint(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                            .background(.terqwaz)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal , 15)
                            .disabled(true)
                            .padding(.bottom, 40)
                    } else {
                        Button(action: {
                            vm.VerfiyOTP()
                        }, label: {
                            Text("Next")
                                .font(.custom("Poppins", size: 18))
                                .fontWeight(.semibold)
                                .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                                .background(.terqwaz)
                                .foregroundStyle(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal , 15)
                        }).padding(.bottom, 40)
                    }
                   
                }.padding()
              
            }.navigationDestination(isPresented: $vm.showHome, destination: {
                HomeTabView()
            })
            .navigationDestination(isPresented: $vm.showCreateAccount, destination: {
                CreateAccountView()
            })
            .toolbar(.hidden)
        }
    }
    var PINView : some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(0..<pinLength, id: \.self) { index in
                    let digit = index < pin.count ? String(pin[pin.index(pin.startIndex, offsetBy: index)]) : ""
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 53, height: 50)
                        .foregroundColor(.terqwaz)
                        .allowsHitTesting(false)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(vm.verificationCodeError ? Color.red : Color.clear , lineWidth : 2)
                        }
                        .overlay(
                            Text(digit)
                                .font(.custom("Poppins", size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .allowsHitTesting(false)
                        )
                        .background(
                            TextEditor(text: $pin)
                                .foregroundColor(.clear)
                                .background(Color.clear)
                                .frame(width: 50, height: 50)
                                .opacity(0.05)
                                .textContentType(.oneTimeCode)
                                
                        )
                }
            }.onChange(of: pin, { oldValue, newValue in
                if newValue.count == pinLength {
                    vm.verificationCode = newValue
                    vm.VerfiyOTP()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                
            })
            .padding(.horizontal)
            
        }
    }
}
#Preview {
    AuthentecationVerifyView()
   
}



        
        
        
        
    



