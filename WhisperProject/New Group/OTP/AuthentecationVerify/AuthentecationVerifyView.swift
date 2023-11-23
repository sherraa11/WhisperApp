//
//  AuthentecationVerifyView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import SwiftUI

struct AuthentecationVerifyView: View {
    @StateObject private var vm = AuthentecationVerifyViewModel()
    @Environment(\.dismiss) var dismiss
    @FocusState private var isTextFieldFoucsed : Bool
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack(spacing: 20){
                    
                    Image(.icon4)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .overlay(
                            Image(systemName:"chevron.left")
                                .foregroundStyle(Color("middleColor"))
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .offset (x:-170 ,y: -245)
                                .onTapGesture {
                                    self.dismiss()
                                }
                        )
                    
                    Text("Verification Code")
                        .foregroundStyle(Color("dark1"))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Text("Please Enter The Verification Code")
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    HStack{
                        TextField("Code ", text: $vm.verificationCode)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color("bcolor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .focused($isTextFieldFoucsed)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(vm.verificationCodeError ? Color.red : Color.clear , lineWidth : 1.5)
                            }
                    }
                    if vm.isLoading {
                        ProgressView()
                            .tint(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                            .background(Color("middleColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .disabled(true)
                    }else { Button(action: {
                        vm.VerfiyOTP()
                        isTextFieldFoucsed = false
                    }, label: {
                        Text("Verify")
                            .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                            .background(Color("middleColor"))
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    }
                }
                .sheet(isPresented: $vm.showCreateAccount, content: {
                    CreateAccountView().presentationDetents([ .large , .fraction(0.8)]).cornerRadius(30, corners: [.topLeft ,.topRight])
                })
                .padding()
                .navigationBarBackButtonHidden()
            }.navigationDestination(isPresented:$vm.showHome) {
                HomeView()
            }
        }.toolbar(.hidden)
    }
}
