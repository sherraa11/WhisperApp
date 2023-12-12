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
    @State var selectedDate = Date()
    
       let startDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
       let endDate = Calendar.current.date(byAdding: .year, value: -13, to: Date())! // Assuming minimum age is 13 years

    @State var fullName : String = ""
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
                    Text("Personal Information")
                        .foregroundColor(Color.black)
                        .font(.custom("Poppins", size: 20))
                        .fontWeight(.semibold)
                        .padding(.top , 45)
                    
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
                        .fontWeight(.medium)
                        .padding()
                        .background(.textFieldbackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(vm.showStatusError ? Color.red : Color.terqwaz, lineWidth: 1)
                        )
                    Spacer()
                    if false {
                        ProgressView()
                            .tint(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                            .background(.terqwaz)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal , 15)
                            .disabled(true)
                    } else {
                        Button(action: {
                            
                            vm.CreateUser()
                        }, label: {
                            Text("Create")
                                .font(.custom("Poppins", size: 18))
                                .fontWeight(.semibold)
                                .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                                .background(.terqwaz)
                                .foregroundStyle(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.leading , 15)
                                .padding(.trailing , 15)
                        })
                    }
                    Spacer()
                }
                .padding()
              
            }
        }.navigationDestination(isPresented: $vm.showHome, destination: {
            HomeTabView()
        })
        .toolbar(.hidden)
    }
}

#Preview {
    CreateAccountView()
}
//    NavigationStack{
//        VStack(alignment: .leading , spacing: 15){
//            HStack { Spacer()
//                Text("Create Account")
//                    .foregroundStyle(Color("dark1"))
//                    .font(.title)
//                Spacer()
//            }
//            .padding(.bottom,20)
//            HStack{
//                Spacer()
//                
//                PhotosPicker(selection: $vm.imageSelection, matching: .images ) {
//                    
//                    if vm.selectedImage == nil {
//                        Image(systemName: "person.crop.circle.badge.plus")
//                            .resizable()
//                            .frame(width: 100 , height: 80)
//                            .foregroundStyle(vm.showImageError ? Color.red.opacity(0.8) : Color("middleColor"))
//            
//                    }else {
//                        Image(uiImage: vm.selectedImage!)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 100 , height: 100)
//                            .clipShape(Circle())
//                    }
//                }
//                Spacer()
//            }
//            
//            
//            Text("Please enter your name")
//                .font(.body)
//                .foregroundStyle(Color.gray)
//                .padding(.top , 12)
//            
//            
//            TextField("name", text: $vm.name)
//                .padding()
//                .background(Color("bcolor"))
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .overlay {
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(vm.showNameError ? Color.red : Color.clear , lineWidth : 1.5)
//                }
//            
//            Text("About you .. ")
//                .font(.body)
//                .foregroundStyle(Color.gray)
//                .padding(.top , 12)
//            
//            
//            TextField("status", text:$vm.status)
//                .padding()
//                .background(Color("bcolor"))
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .overlay {
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(vm.showStatusError ? Color.red : Color.clear , lineWidth : 1.5)
//                }
//            
//            
//            Button(action: {
//                vm.CreateUser()
//            }, label: {
//                Text("Create")
//                    .font(.custom("Proxima Nova", size: 18))
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity )
//                    .frame(height: 55)
//                    .background(Color("middleColor"))
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    .foregroundColor(.white)
//                    .padding(.bottom, 10)
//            }).padding(.top,25)
//        }.padding()
//            .fullScreenCover(isPresented: $vm.showHome, content: { HomeView() })
//    }
//}
