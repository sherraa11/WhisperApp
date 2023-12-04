//
//  HomeView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct HomeView: View {
    @ObservedObject var vm = HomeViewModel()
    @State var text : String = ""
    @State var displayedText : String = ""
    var body: some View {
        NavigationStack{
            VStack {
                if vm.isSearching() {
                    List(vm.filteredFriends) { friend in
                        NavigationLink {
                            ChatView(user: friend)
                        } label: {
                            RowSearchView(user: friend)
                        }
                    }
                }else if vm.isLoading {
                    VStack {
                        LoadingIndicator(animation: .threeBallsBouncing, color: .primary , size: .medium, speed: .normal)
                            .offset(y: -20)
                        Text(displayedText)
                            .fontWeight(.medium)
                            .font(.system(size: 18))
                            .foregroundStyle(.primary)
                    }
                }else{
                    List(vm.friendList){ friend in
                        NavigationLink {
                            ChatView(user: friend.userModel)
                        } label: {
                            RowView(UserView: friend)
                        }
                    }
                }
            }.listStyle(.plain)
                .navigationTitle("Chats")
                .onAppear{
                    UserDefaults.standard.set( true, forKey: "showHome")
                    DispatchQueue.main.asyncAfter(deadline: .now()+2){
                        if vm.isLoading {
                            withAnimation {
                                text = "Start chatting with friends today!"
                                displayTextLetterByLetter()
                            }
                        }
                    }
                }
            .searchable(text: $vm.searchText , placement: .navigationBarDrawer(displayMode: .automatic))
        }
    }
}


#Preview {
    HomeView()
}

extension HomeView {
    func displayTextLetterByLetter() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { timer in
            if !text.isEmpty {
                displayedText += String(text.removeFirst())
            } else {
                timer.invalidate()
            }
        }
        timer.fire()
    }
    
}
