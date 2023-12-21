//
//  HomeTabView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 06/12/2023.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {

            TabView {
                HomeView()
                
                    .tabItem {HStack{
                        Image(systemName: "house")
                        Text("Home")
                    }}
                SearchView()
                
                    .tabItem {HStack{
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }}
                CreatePostView()
                    .tabItem {HStack{
                        Image(systemName: "plus.square.dashed")
                        Text("Create")
                    }}
                ChatView()
                
                    .tabItem {HStack{
                        Image(systemName: "ellipsis.message")
                        Text("Chats")
                    }}
                ProfileView()
                    .tabItem {HStack{
                        Image(systemName: "person")
                        Text("Profile")
                    }}
            
            }.onAppear{
                UserDefaults.standard.set(true, forKey: "showHome")
            }
            .tint(.terqwaz)
        .toolbar(.hidden)
    }
}

#Preview {
    HomeTabView()
}
