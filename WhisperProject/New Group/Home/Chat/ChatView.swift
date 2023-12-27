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
                    
                    LoadingIndicator(animation: .fiveLines, color: .primary , size: .medium, speed: .normal)
                    Text("Let's get chatting!\nSend a message and make your first conversation happen.")
                        .font(.custom("Poppins", size: 18))
                        .listStyle(.plain)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                    
                    
                            .navigationTitle("Chats")
                            .navigationBarTitleDisplayMode(.inline)
                    
                } else {
                    List(vm.friendList) { friend in
                        ZStack{
                            RowView(UserView: friend)
                            NavigationLink {
                                MessageingView(user: friend.userModel, arrow: "left")
                            } label: {
                                
                            }.opacity(0)
                        }
                    }.listStyle(.plain)
                        .navigationTitle("Chats")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
        .onAppear {
            vm.getFriendsList() // Trigger data fetching when the view appears
        }
    }
}
#Preview {
    ChatView()
}
