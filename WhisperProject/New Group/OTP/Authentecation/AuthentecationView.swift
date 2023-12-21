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
    @State var selection : Country = Country(name: "Egypt", code: "+01", flag: "")
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 5){
                    Image(systemName:"chevron.left")
                        .foregroundStyle(.black)
                        .font(.system(size: 25))
                        .fontWeight(.light)
                        .opacity(0)
                    Text("Phone")
                        .foregroundColor(Color.black)
                        .font(.custom("Poppins", size: 20))
                        .fontWeight(.semibold)
                        .padding(.top , 45)
                    
                    Text("Enter your phone number")
                        .foregroundColor(Color.black)
                        .font(.custom("Poppins", size: 16))
                        .fontWeight(.medium)
                        .opacity(0.7)
                        .padding(.bottom , 10)
                    
                        HStack {
                            Text("  \(selection.flag)")
                            Text("\(selection.code)  ")
                                .font(.custom("Poppins", size: 16))
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.5))
                            
                            TextField(text:$vm.phoneNumber) {
                                Text("Phone number")
                                    .font(.custom("Poppins", size: 16))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.5))
                                    .keyboardType(.numberPad)
                                    .padding()
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .focused($isTextFieldFoucsed)
                                    
                            }.keyboardType(.numbersAndPunctuation)
                            .frame(height: 50)
                                .foregroundStyle(.black.opacity(0.5))
                    }.overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(vm.phoneNumberError ? Color.red : Color.terqwaz , lineWidth : 1.5)
                    }
                    Spacer()
                    Picker("", selection: $selection) {
                        ForEach(arabianCountries) { country in
                            HStack{
                                Text("\(country.flag)")
                                Group{
                                    Text("\(country.name) ")
                                    Text("|")
                                        .font(.system(size: 20))
                                        .fontWeight(.light)
                                    
                                    Text("\(country.code)")
                                }.foregroundColor(Color.black)
                                    .font(.custom("Poppins", size: 16))
                                    .fontWeight(.medium)
                            }.tag(country)
                        }
                    }
                    .pickerStyle(.wheel)
                    .foregroundStyle(.terqwaz)
                        .onChange(of: selection) { old, new in
                            vm.cityCode = new.code
                        }
                    Spacer()
                    Spacer()
                    if vm.isLoading {
                        ProgressView()
                            .tint(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                            .background(.terqwaz)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal , 15)
                            .padding(.bottom, 40)
                            
                            .disabled(true)
                    } else {
                        Button(action: {
                            vm.Singup()
                            isTextFieldFoucsed = false
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
