//
//  ChatView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct ChatView: View {
    @ObservedObject var vm = ChatViewModel()
    @State private var isShowingMessageView: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                if vm.isLoading {
                    
                    LoadingIndicator(animation: .threeBallsBouncing, color: .primary , size: .medium, speed: .normal)
                        .listStyle(.plain)
                            .navigationTitle("Chats")
                            .navigationBarTitleDisplayMode(.inline)
                } else {
                    List(vm.friendList) { friend in
                        Button(action: {
                            isShowingMessageView.toggle()
                            vm.selectedFriend = friend // Optionally update based on click
                        }) {
                            RowView(UserView: friend)
                        }
                    }.listStyle(.plain)
                        .navigationTitle("Chats")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }.fullScreenCover(isPresented: $isShowingMessageView, content: {
                if vm.selectedFriend != nil{
                    MessageingView(user: vm.selectedFriend!.userModel)
                        .transition(.move(edge: .leading))
                }
            })
        }
        .onAppear {
            vm.getFriendsList() // Trigger data fetching when the view appears
        }
    }
}
#Preview {
    ChatView()
}
