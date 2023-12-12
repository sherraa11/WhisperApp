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
            Text("home")
                .tabItem {HStack{
                    Image(systemName: "house")
                }}
            Text("search")
                .tabItem {HStack{
                    Image(systemName: "magnifyingglass")
                }}
            Text("create post")
                .tabItem {HStack{
                    Image(systemName: "plus.square.dashed")
                }}
            Text("chats")
                .tabItem {HStack{
                    Image(systemName: "ellipsis.message")
                }}
            ProfileView()
                .tabItem {HStack{
                    Image(systemName: "person")
                }}
           
        }
            
    }
}

#Preview {
    HomeTabView()
}
