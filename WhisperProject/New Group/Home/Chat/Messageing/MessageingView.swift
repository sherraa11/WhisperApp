//
//  MessageingView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 15/12/2023.
//

import SwiftUI

struct MessageingView: View{
    
    @ObservedObject var messagesManager = MessagesManager.shared
    @ObservedObject var vm = MessagingViewModel()
    
    @State var user: UserModel
    @State var chatid: String?
    
    @State private var isTabBarHidden = true
    @State  var arrow : String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    TitleRow(user: user, arrow: arrow)
                    Divider()
                    
                    ScrollViewReader { proxy in
                        ScrollView {
                            ForEach(messagesManager.messages, id: \.id) { message in
                                MessageBubble(message: message)
                            }
                            .onChange(of: messagesManager.lastMessageId) { _ , _ in
                                DispatchQueue.main.async {
                                    proxy.scrollTo(messagesManager.lastMessageId ?? "", anchor: .bottom)
                                }
                            }
                        }
                        .background(Color.white)
                        
                        .onAppear {
                            // Scroll to the last message when the view appears
                            withAnimation {
                                isTabBarHidden = true
                            }
                            DispatchQueue.main.async {
                                proxy.scrollTo(messagesManager.lastMessageId ?? "", anchor: .bottom)
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
                
                
                MessageField(user: user.id, chatid: vm.createChatRoomId(secndUserId: user.id))
            }
            .toolbar(isTabBarHidden ? .hidden : .visible, for: .tabBar)
            .onAppear {
                chatid = vm.createChatRoomId(secndUserId: user.id)
                guard let chatid = chatid else { return }
                messagesManager.getMessages(chatId: chatid)
                
                // Set lastMessageId to the ID of the last message in the chat here
                if let lastMessageId = messagesManager.messages.last?.id {
                    messagesManager.lastMessageId = lastMessageId
                }
            }
            .toolbar(.hidden)
            .gesture(DragGesture().onEnded({ gesture in
                if gesture.translation.width > 100  {
                    dismiss()
                }
            }))
        }
    }
}
    
