//
//  CreateAccountView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//

import SwiftUI
import PhotosUI



struct CreateAccountView: View {
    @ObservedObject var vm = CreateAccountViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 5){
                    Text("Personal Information")
                        .foregroundColor(Color.black)
                        .font(.custom("Poppins", size: 20))
                        .fontWeight(.semibold)
                        .padding(.top , 25)
                    
                    Text("Please fill the following")
                        .foregroundColor(Color.black)
                        .font(.custom("Poppins", size: 16))
                        .fontWeight(.medium)
                        .opacity(0.7)
                        .padding(.bottom , 10)
                    HStack{Spacer()
                        PhotosPicker(selection: $vm.imageSelection, matching: .images ) {
                            
                            if vm.selectedImage == nil {
                                Image(systemName: "person.crop.circle.badge.plus")
                                    .resizable()
                                    .frame(width: 100 , height: 80)
                                    .foregroundStyle(vm.showImageError ? Color.red.opacity(0.8) : Color(.terqwaz))
                                
                            }else {
                                Image(uiImage: vm.selectedImage!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100 , height: 100)
                                    .clipShape(Circle())
                            }
                        }
                        Spacer()
                    }.padding(.top , 10)
                    HStack {
                        Text("Full name ")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                        Spacer()}
                    TextField("", text: $vm.name)
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.medium)
                        .padding()
                        .autocorrectionDisabled()
                        .background(.textFieldbackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(vm.showNameError ? Color.red : Color.terqwaz , lineWidth : 1)
                        }
                    
                    
                    HStack {
                        Text("Username ")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                        Spacer()}.padding(.top ,12)
                    TextField("", text: $vm.username)
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.medium)
                        .padding()
                        .background(.textFieldbackground)
                        .autocorrectionDisabled()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(vm.showUserNameError ? Color.red : Color.terqwaz , lineWidth : 1)
                        }
                    HStack {
                        Text("About ")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                        Spacer()}.padding(.top ,12)
                    TextField("", text: $vm.status)
                        .font(.custom("Poppins", size: 14))
                        .autocorrectionDisabled()
                        .fontWeight(.medium)
                        .padding()
                        .background(.textFieldbackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(vm.showStatusError ? Color.red : Color.terqwaz, lineWidth: 1)
                        )
                    Spacer()
                    
                    Button {
                        print("Pressed")
                        vm.CreateUser()
                    } label: {
                        Text("Create")
                            .font(.custom("Poppins", size: 18))
                            .fontWeight(.semibold)
                            .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                            .background(.terqwaz)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom , 40)
                            .padding(.leading , 15)
                            .padding(.trailing , 15)
                    }
                }
                .padding()
            }
        }.navigationDestination(isPresented: $vm.showHome, destination: {
            HomeTabView()
        })
        .tint(.blue)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreateAccountView()
}
