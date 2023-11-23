//
//  HomeView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm = HomeViewModel()
    var body: some View {
        NavigationStack{
            VStack {
                if vm.isSearching() {
                    List(vm.filteredFriends) { friend in
                        NavigationLink(destination: ChatView(imageUrl: URL(string: friend.profilePhoto)!, name: friend.name, friendUserID: friend.id )) {
                            RowView(imageURL: URL(string: friend.profilePhoto)!, name: friend.name)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Chats")
                }else{
                    List(vm.friendList){ friend in
                        NavigationLink(destination: ChatView(imageUrl: URL(string: friend.profilePhoto)!, name: friend.name, friendUserID: friend.id )) {
                            RowView(imageURL: URL(string: friend.profilePhoto)!, name: friend.name)
                        }
                    }
                    .navigationDestination(for: UserModel.self, destination: { friend in
                        ChatView(imageUrl: URL(string: friend.profilePhoto)!, name: friend.name , friendUserID: friend.id)})
                    .listStyle(.plain)
                        .navigationTitle("Chats")
                }
            }
        }.onAppear{UserDefaults.standard.set( true, forKey: "showHome")}
        .searchable(text: $vm.searchText , placement: .navigationBarDrawer(displayMode: .automatic))
    }
}

#Preview {
    HomeView()
}


