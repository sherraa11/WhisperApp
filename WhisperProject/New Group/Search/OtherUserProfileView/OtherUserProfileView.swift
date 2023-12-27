//
//  OtherUserProfileView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 12/12/2023.
//

import SwiftUI
import Kingfisher
//
//
//class OtherUserProfileViewModel : ObservableObject {
//    
//    @Published var profilePhotos = [String]()
//    @Published var showNoPosts: Bool = true
//    
//
//    
//    func getPostPhotos(id : String){
//        FirestoreManager.shared.getProfilePhotos(forUser: id) { photos in
//            if let Photos = photos {
//                DispatchQueue.main.async {
//                    self.profilePhotos.removeAll()
//                    self.profilePhotos = Photos
//                    self.showNoPosts = Photos.isEmpty
//                }
//            }
//        }
//    }
//}

struct OtherUserProfileView: View {
//    @ObservedObject var vm = OtherUserProfileViewModel()
    @Environment(\.dismiss) var dismiss
    @State var user : UserModel
    @State var showMessaging: Bool = false
    @State var showNoPosts: Bool = false
    @State var profilePhotos = [String]()
    @State var isLoading: Bool = false

    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    KFImage(URL(string: user.profilePhoto))
                        .placeholder({ loading in
                            Circle()
                                .frame(width: 67 , height: 67)
                                .foregroundStyle(.white)
                                .overlay{
                                    Circle()
                                        .stroke(.terqwaz ,lineWidth: 1)
                                    ProgressView()
                                }
                        })
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 67 , height: 67)
                        .clipShape(Circle())
                    VStack{
                        HStack{
                            Text(user.name)
                                .font(.custom("Poppins", size: 18))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        HStack{
                            Text(user.username)
                                .font(.custom("Poppins", size: 14))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    Spacer()
                    Image(.threedots)
                        .font(.system(size: 20))
                }
                    .padding(.horizontal , 28)
                HStack{
                    Text(user.status)
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.medium)
                        .padding(.top , 12)
                    Spacer()
                    Button(action: {
                        showMessaging.toggle()
                    }, label: {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 45, height: 30)
                            .foregroundStyle(.white)
                            .overlay{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black ,lineWidth: 1)
                              
                            }.overlay{
                                Image(systemName: "ellipsis.message")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.black)
                            }
                    }).padding(.top , 12)
                    Button(action: {
                    }, label: {
                        Text("Follow")
                            .font(.custom("Poppins", size: 12))
                            .fontWeight(.semibold)
                            .frame(width:  90, height: 30)
                            .background(.terqwaz)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.top , 12)
                    })
                }.padding(.horizontal ,28 )
                HStack{Spacer()
                    VStack{
                        Text(String(profilePhotos.count))
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
                
                if isLoading {
                    ProgressView()
                        .tint(.terqwaz)
                        .padding(.top, 50)
                        .font(.system(size: 25))
                    Spacer()
                }else if !showNoPosts{
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3 )) {
                            ForEach(profilePhotos, id: \.self) { photo in
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
                            .foregroundStyle(.black.opacity(0.9))
                            .padding()
                            .padding(.top, 20)
                        
                        Text("No posts yet")
                            .font(.custom("Poppins", size: 20))
                            .fontWeight(.semibold)
                        Spacer()
                    }

                }
            }.fullScreenCover(isPresented: $showMessaging, content: {
                MessageingView(user: user , arrow : "down")
            })
            .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Profile")
                .accentColor(.black)
        }.tint(.black)
            .onAppear{
                self.isLoading = true
                FirestoreManager.shared.getProfilePhotos(forUser: user.id) { Photos in
                    if let photos = Photos {
                        DispatchQueue.main.async {
                            self.profilePhotos.removeAll()
                            self.profilePhotos = photos
                            self.showNoPosts = photos.isEmpty
                            self.isLoading = false
                        }
                    }
                }
            }
    }
}

