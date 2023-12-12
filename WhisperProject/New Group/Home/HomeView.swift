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
                        ZStack {
                            RowView(UserView: friend)
                            NavigationLink {
                                ChatView(user: friend.userModel)
                            } label: {
                                
                            }.buttonStyle(.plain)
                                .frame(height: 0)
                                .opacity(0)
                        }
                    }
                }
            }.listStyle(.plain)
                .navigationTitle("Chats")
                .navigationBarTitleDisplayMode(.inline)
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
                .searchable(text: $vm.searchText , placement: .navigationBarDrawer(displayMode: .always))
                .navigationBarBackButtonHidden()
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
