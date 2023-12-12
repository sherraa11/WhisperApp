//
//  ProfileView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 06/12/2023.
//
import SwiftUI
import Kingfisher
import SwiftfulLoadingIndicators

struct ProfileView: View {
    @ObservedObject var vm = ProfileViewModel()
    
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Spacer()
                    Text("My Profile")
                        .font(.custom("Poppins", size: 18))
                        .fontWeight(.semibold)
                    Spacer()
                }.padding(.horizontal)
                HStack{
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 67 , height: 67)
                    VStack{
                        Text("Oyin Dolapo")
                            .font(.custom("Poppins", size: 18))
                            .fontWeight(.semibold)
                        Text("Abdokuta, Ogun")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    Image(systemName: "gear")
                        .font(.system(size: 20))
                        .onTapGesture {
                            vm.showEditProfile.toggle()
                        }
                }.padding(.top , 40)
                    .padding(.horizontal , 28)
                
                Text("I’m a postive person. I love to travel and eat Always available for chat")
                    .font(.custom("Poppins", size: 12))
                    .padding(.trailing , 50)
                //                    .frame(width: UIScreen.main.bounds.width - 100)
                    .fontWeight(.medium)
                    .padding(.horizontal)
                    .padding(.top , 12)
                
                Button(action: {
                    vm.showEditProfile.toggle()
                }, label: {
                    Text("Edit Profile")
                        .font(.custom("Poppins", size: 12))
                        .fontWeight(.semibold)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                        .background(.terqwaz)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top , 24)
                })
                
                HStack{Spacer()
                    VStack{
                        Text("87")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.semibold)
                        Text("Posts")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.regular)
                    }
                    Spacer()
                    Divider().frame(height: 34)
                        .foregroundStyle(.black)
                    Spacer()
                    VStack{
                        Text("870")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.semibold)
                        Text("Following")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.regular)
                    }
                    Spacer()
                    Divider().frame(height: 34)
                        .foregroundStyle(.black)
                    Spacer()
                    VStack{
                        Text("15k")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.semibold)
                        Text("Followers")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.regular)
                    }
                    Spacer()
                }
                .padding(.top , 15)
                HStack{
                    Text("Posts")
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.regular)
                    Spacer()
                }.padding(.top,20)
                    .padding(.horizontal, 32)
                ScrollView{
                    VStack(spacing: 8) {
                        ForEach(0..<10) { index in // Change the range or use your image data here
                            HStack(spacing: 10) {
                                ForEach(0..<3) { innerIndex in
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.gray) // Change color as per your image
                                        .frame(width: 99, height: 99) // Adjust image frame size
                                    // Replace this with your image loading logic
                                        .overlay(Text("Image \(innerIndex + (index * 3) + 1)")) // Placeholder text
                                }
                            }
                        }
                    }
                    
                }.scrollIndicators(.hidden)
            }.fullScreenCover(isPresented: $vm.showEditProfile, content: {
                EditProfileView()
            })
           
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ProfileView()
}
