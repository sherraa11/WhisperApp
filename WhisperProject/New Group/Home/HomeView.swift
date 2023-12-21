//
//  HomeView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 12/12/2023.
//

import SwiftUI

struct HomeView: View {
    @State var searchText : String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 335, height: 34)
                    .foregroundStyle(.clear)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.terqwaz , lineWidth:1)
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 10))
                                .padding(.horizontal ,9)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        TextField("Type something ......",text: $searchText)
                            .font(.custom("Poppins", size: 10))
                        
                            .fontWeight(.medium)
                            .padding(.leading , 25)
                    }
                ScrollView{
                    ForEach(1..<10){ index in
                        PostView()
                    }
                }.scrollIndicators(.hidden)
                    .toolbar(.visible)
            }
        }
    }
}

#Preview {
    HomeView()
}

struct PostView: View {
    var post : String = "hello how are you guys  fsdafhdshfhdsahf hdshfhsda hh' fdsafdsf dsf dsf dsfdsf dsf sdfds"
    var body: some View {
        VStack{
            Color.textFieldbackground
                
                .frame(height: 5)
                .padding(.bottom , 8)
            HStack{
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 46 , height: 46)
                    .clipShape(Circle())
                VStack(alignment:.leading){
                    Text("Oyin Dolapo")
                        .font(.custom("Poppins", size: 18))
                        .fontWeight(.semibold)
                    Text("Oyin Dolapo")
                        .font(.custom("Poppins", size: 12))
                        .fontWeight(.medium)
                }
                Spacer()
            }.padding(.horizontal , 20)
            HStack{
                Text("\(post)")
                    .font(.custom("Poppins", size: 14))
                    .multilineTextAlignment(.leading)
                    .fontWeight(.medium)
                    .lineLimit(nil)
                    .padding(.horizontal , 20)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            Image(.icon2)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 54, height: UIScreen.main.bounds.height / 3)
                .clipShape(.rect(cornerRadius: 10))
            
            HStack{
                Image(systemName: "heart")
                    .padding(.leading,20)
                    .font(.system(size: 20))
                
                
                Text("24")
                    .font(.custom("Poppins", size: 12))
                    .fontWeight(.medium)
                
                Image(systemName: "ellipsis.message")
                    .padding(.leading,3)
                    .font(.system(size: 17))
                
                
                Text("8")
                    .font(.custom("Poppins", size: 12))
                    .fontWeight(.medium)
                
                
                Spacer()
            }.padding(.top , 7)
        }.padding(.top , 8)
    }
}
        
//        VStack {
//            
//            RoundedRectangle(cornerRadius: 10)
//                .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 3 + 170)
//                .foregroundStyle(.textFieldbackground)
//                .overlay {
//                    VStack{
//                        VStack{
//                            HStack{
//                                Image(systemName: "person.circle")
//                                    .resizable()
//                                    .frame(width: 46 , height: 46)
//                                    .clipShape(Circle())
//                                VStack(alignment:.leading){
//                                    Text("Oyin Dolapo")
//                                        .font(.custom("Poppins", size: 18))
//                                        .fontWeight(.semibold)
//                                    Text("Oyin Dolapo")
//                                        .font(.custom("Poppins", size: 12))
//                                        .fontWeight(.medium)
//                                }
//                                Spacer()
//                            }.padding(.horizontal , 20)
//                        }
//                        Text("\(post)")
//                        
//                            .font(.custom("Poppins", size: 14))
//                            .multilineTextAlignment(.leading)
//                            .fontWeight(.medium)
//                            .lineLimit(nil)
//                            .padding(.horizontal , 20)
//                            .fixedSize(horizontal: false, vertical: true)
//                        
//                        Image(.icon2)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: UIScreen.main.bounds.width - 54, height: UIScreen.main.bounds.height / 3)
//                            .clipShape(.rect(cornerRadius: 10))
//                            .overlay{
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(lineWidth: 1)
//                            }
//                        HStack{
//                            Image(systemName: "heart")
//                                .padding(.leading,20)
//                                .font(.system(size: 20))
//                               
//                            
//                            Text("24")
//                                .font(.custom("Poppins", size: 12))
//                                .fontWeight(.medium)
//                            
//                            Image(systemName: "ellipsis.message")
//                                .padding(.leading,3)
//                                .font(.system(size: 17))
//                            
//                                
//                            Text("8")
//                                .font(.custom("Poppins", size: 12))
//                                .fontWeight(.medium)
//                            
//                            
//                            Spacer()
//                        }.padding(.top , 7)
//                    }
//                    
//                }
//        }

