//
//  OtherUserProfileView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 12/12/2023.
//

import SwiftUI
import Kingfisher

struct OtherUserProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State var user : UserModel
    @State var showMessaging: Bool = false
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
                        .font(.custom("Poppins", size: 12))
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
            }.fullScreenCover(isPresented: $showMessaging, content: {
                MessageingView(user: user)
            })
            .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Profile")
                .accentColor(.black)
        }
    }
}

