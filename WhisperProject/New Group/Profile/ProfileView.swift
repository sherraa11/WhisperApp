//
//  ProfileView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 06/12/2023.
//
import SwiftUI
import Kingfisher
import SwiftfulLoadingIndicators
import Shimmer

struct ProfileView: View {
    @ObservedObject var vm = ProfileViewModel()
    @State var select : String = ""
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    if let image = vm.photoURL{
                        KFImage(image)
                            .placeholder({ loading in
                                Circle()
                                    .frame(width: 67 , height: 67)
                                    .foregroundStyle(.white)
                                    .overlay{
                                        Circle()
                                            .stroke(.terqwaz ,lineWidth: 1)
                                        ProgressView()
                                            .tint(.terqwaz)
                                    }
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 67 , height: 67)
                            .clipShape(Circle())
                        
                    }else{
                        Circle()
                            .frame(width: 67 , height: 67)
                            .foregroundStyle(.white)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    VStack{HStack{
                        Text(vm.updatedFullName)
                            .font(.custom("Poppins", size: 18))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                        HStack{
                            Text(vm.updatedUserName)
                                .font(.custom("Poppins", size: 14))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 20))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal , 28)
                HStack{
                    
                    Text(vm.updatedStatus)
                        .font(.custom("Poppins", size: 12))
                        .padding(.trailing , 50)
                        .fontWeight(.medium)
                        .padding(.horizontal, 30)
                        .padding(.top , 12)
                    Spacer()
                }
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
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("My Profile")
                .navigationBarBackButtonHidden()
                .onReceive(vm.$shouldRefreshData) { shouldRefresh in
                    if shouldRefresh {
                        vm.getCurrentUserInfo() // Fetch new data when the flag is true
                        vm.shouldRefreshData = false // Reset the flag
                    }
                }
                .fullScreenCover(isPresented: $vm.showEditProfile, onDismiss: {
                    vm.shouldRefreshData = true
                }, content: {
                    EditProfileView()
                })
        }
    }
}

#Preview {
    ProfileView()
}
