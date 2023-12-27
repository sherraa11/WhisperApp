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
                        vm.showSettings.toggle()
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 20))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal , 28)
                HStack{
                    
                    Text(vm.updatedStatus)
                        .font(.custom("Poppins", size: 14))
                        .padding(.trailing , 50)
                        .fontWeight(.medium)
                        .padding(.horizontal, 30)
                        .padding(.top , 14)
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
                        Text(String(vm.profilePhotos.count))
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
                if !vm.showNoPosts{
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3 )) {
                            ForEach(vm.profilePhotos, id: \.self) { photo in
                                if photo != ""{
                                    KFImage(URL(string: photo))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width / 3 - 5 , height: UIScreen.main.bounds.width / 3 - 5)
                                        .cornerRadius(8) // Apply corner radius if needed
                                }
                            }
                        }
                        .padding(5)
                    }
                    .scrollIndicators(.hidden)
                }else{
                    VStack{
                        Image(systemName:"camera.circle")
                            .font(.system(size: 50))
                            .padding()
                        
                        Text("No posts yet")
                            .font(.custom("Poppins", size: 20))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
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
                .sheet(isPresented: $vm.showSettings) {
                    SettingsView().presentationDetents([.fraction(0.2)])
                }
        }
    }
}

#Preview {
    ProfileView()
}
