//
//  AuthentecationView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import SwiftUI


struct AuthentecationView: View {
    @StateObject private var vm = AuthentecationViewModel()
    @FocusState private var isTextFieldFoucsed : Bool
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack(spacing: 20){
                    Image(.icon4)
                        .resizable()
                        .frame(width: 200, height: 200)
                    
                    Text("Verify Your Number")
                        .foregroundStyle(Color("dark1"))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Text("Please Enter Your Number To Verify Your Account")
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    HStack{
                        TextField("20", text: $vm.cityCode)
                            .keyboardType(.numberPad)
                            .frame(width: 45)
                            .padding()
                            .background(Color("bcolor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .focused($isTextFieldFoucsed)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(vm.cityCodeError ? Color.red : Color.clear , lineWidth : 1.5)
                            }
                        TextField("Number", text: $vm.phoneNumber)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color("bcolor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .focused($isTextFieldFoucsed)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(vm.phoneNumberError ? Color.red : Color.clear , lineWidth : 1.5)
                            }
                    }
                    if vm.isLoading {
                        ProgressView()
                            .tint(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                            .background(Color("middleColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .disabled(true)
                    } else {
                        Button(action: {
                            vm.Singup()
                            isTextFieldFoucsed = false
                        }, label: {
                            Text("Send")
                                .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                                .background(Color("middleColor"))
                                .foregroundStyle(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        })
                    }
                }
                .padding()
                .navigationDestination(isPresented: $vm.showVerify) {
                    AuthentecationVerifyView()
                }
            }
        }
        .toolbar(.hidden)
    }
}

#Preview {
    AuthentecationView()
}
