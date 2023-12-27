//
//  HomeView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 12/12/2023.
//

import SwiftUI
import Kingfisher
import Shimmer


struct HomeView: View {
    @State var searchText : String = ""
    @State var showShimer : Bool = false
    @ObservedObject var vm = HomeViewModel()
    
    
    var body: some View {
        NavigationStack{
            VStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 335, height: 40)
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
                            .font(.custom("Poppins", size: 14))
                            .frame(height: 40)
                            .fontWeight(.medium)
                            .padding(.leading , 25)
                    }
                VStack{
                    if let allPost = vm.allPost{
                        if !allPost.isEmpty{
                            ScrollView {
                                LazyVStack(spacing: 0) {
                                    ForEach(allPost) { post in
                                        PostView(post: post)
                                    }
                                }
                            }.scrollIndicators(.hidden)
                        }else {
                            Spacer()
                            
                            Image(systemName: "text.below.photo.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(.gray)
                            Text("Looks like there's nothing here yet.\n be the first to post!")
                                .font(.system(size: 18))
                                .multilineTextAlignment(.center)
                                .padding(.top, 8)
                            
                            Spacer()
                            Spacer()
                            
                        }
                    } else {
                        ScrollView {
                            ForEach(1..<3) { _ in
                                Postskeleton()
                                    .shimmering(active: showShimer ? true : false)
                                
                            }.onAppear{
                                showShimer = true
                            }
                        }.scrollIndicators(.hidden)
                    }
                }
                
            }.toolbar(.visible)
                .navigationTitle("Feed")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}

struct PostView: View {
    var post : PostsModel
    var body: some View {
        VStack{
            Color.textFieldbackground
            
                .frame(height: 5)
                .padding(.bottom , 8)
            HStack{
                KFImage(URL(string: post.userWhoCreateThePost.profilePhoto))
                    .placeholder {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 46, height: 46)
                            .clipShape(Circle())
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 46 , height: 46)
                    .clipShape(Circle())
                VStack(alignment:.leading){
                    Text(post.userWhoCreateThePost.name)
                        .font(.custom("Poppins", size: 18))
                        .fontWeight(.semibold)
                    Text(post.userWhoCreateThePost.username)
                        .font(.custom("Poppins", size: 12))
                        .fontWeight(.medium)
                }
                Spacer()
            }.padding(.horizontal , 20)
            HStack{
                Text(post.caption)
                    .font(.custom("Poppins", size: 14))
                    .multilineTextAlignment(.leading)
                    .fontWeight(.medium)
                    .lineLimit(nil)
                    .padding(.horizontal , 20)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            if !post.postPhoto.isEmpty {
                KFImage(URL(string: post.postPhoto))
                
                    .resizable()
                    .scaledToFit()
                    .previewLayout(.sizeThatFits)
                
            }
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
struct Postskeleton : View {
    var body: some View{
        
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
            }
            .padding(.horizontal , 20)
            
            HStack{
                Text(" fasdfsdafdasfasdfdsfasdff ")
                    .font(.custom("Poppins", size: 14))
                    .multilineTextAlignment(.leading)
                    .fontWeight(.medium)
                    .padding(.leading,10)
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
            
        } .redacted(reason: .placeholder)
        
            .padding(.top , 15)
        
    }
    
}
