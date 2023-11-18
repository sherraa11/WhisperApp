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
                        NavigationLink(value: friend) {
                            RowView(imageURL: URL(string: friend.profilePhoto)!, name: friend.name)
                        }
                    }.listStyle(.plain)
                        .navigationTitle("Chats")
                    
                }else{
                    List(){
                        ForEach(1..<10) { user in
                            
                            NavigationLink(value: user) {
                                RowView(imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/chatapp-9879e.appspot.com/o/ie2WBFTrAgUzPMsTw0MjWyOdJnA2?alt=media&token=b4466f6a-b8c7-474f-86d8-167088086d9c")!,
                                        name: "عشري")
                            }
                        }
                    }.listStyle(.plain)
                        .navigationTitle("Chats")
                }
            }.navigationDestination(for: FriendsModel.self, destination: { friend in
                Text(friend.name)
                Text(friend.status)
            })
            .navigationDestination(for: Int.self) { user in
                Text("\(user)")
            }
        
        }
        .searchable(text: $vm.searchText , placement: .navigationBarDrawer(displayMode: .always))
    }
}

#Preview {
    HomeView()
}


