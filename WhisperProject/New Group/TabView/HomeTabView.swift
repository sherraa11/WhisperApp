//
//  HomeTabView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 06/12/2023.
//

import SwiftUI


struct HomeTabView: View {
    @AppStorage("counter") var counter : Int = 0
    @State var selectedTab : Int = 2
    var body: some View {
        TabView(selection:$selectedTab) {
            HomeView()
                .onAppear{counter = 0}
                .tabItem {HStack{
                    Image(systemName: "house")
                    Text("Home")
                        
                }}.tag(1)
            SearchView()
                .tint(.black)
                .tabItem {HStack{
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }}.tag(2)
            CreatePostView()
                .tint(.black)
                .tabItem {HStack{
                    Image(systemName: "plus.square.dashed")
                    Text("Create")
                }}.tag(3)
            ChatView()
                .tint(.black)
                .tabItem {HStack{
                    Image(systemName: "ellipsis.message")
                    Text("Chats")
                }}
                .tag(4)
            ProfileView()
                .tint(.black)
                .tabItem {HStack{
                    Image(systemName: "person")
                    Text("Profile")
                }}.tag(5)
        }
   
        .toolbar(.hidden)
        .onAppear{
            UserDefaults.standard.set(true, forKey: "showHome")
            NotficationManager.shared.requestAuthorizatoin()
        }
        .onChange(of: counter, { oldValue, newValue in
            if selectedTab != 1 {
                selectedTab = 1
            }
        })
        .tint(.terqwaz)
      
        
    }
}

#Preview {
    HomeTabView()
}
