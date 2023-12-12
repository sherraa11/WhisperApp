//
//  OtherUserProfileView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 12/12/2023.
//

import SwiftUI

struct OtherUserProfileView: View {
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Spacer()
                    Text("Profile")
                        .font(.custom("Poppins", size: 18))
                        .fontWeight(.semibold)
                    Spacer()
                }.overlay(content: {
                    HStack{
                        Image(systemName:"chevron.left")
                            .foregroundStyle(.black)
                            .font(.system(size: 25))
                            .fontWeight(.light)
                        Spacer()
                    }
                })
                .padding(.horizontal)
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
                    Image(.threedots)
                        .font(.system(size: 20))
                }.padding(.top , 40)
                    .padding(.horizontal , 28)
                HStack{
                    Text("I’m a postive person. I love to travel and eat Always available for chat")
                        .font(.custom("Poppins", size: 12))
                        .padding(.trailing , 50)
                    //                    .frame(width: UIScreen.main.bounds.width - 100)
                        .fontWeight(.medium)
                        .padding(.trailing , 20)
                        .padding(.top , 12)
                    
                    
                    
                    Button(action: {
                        
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
                            
                            .padding(.top, 24)
                            
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Follow")
                            .font(.custom("Poppins", size: 12))
                            .fontWeight(.semibold)
                            .frame(width:  90, height: 30)
                            .background(.terqwaz)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.top , 24)
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
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    OtherUserProfileView()
}
