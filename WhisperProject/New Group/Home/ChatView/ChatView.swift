//
//  ChatView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var messagesManager = MessagesManager.shared
    @ObservedObject var vm = ChatViewModel()
    
    @State var user: UserModel
    @State var chatid: String?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    TitleRow(user: user)
                    
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
                        .padding(.top, 10)
                        .background(Color.white)
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                        .onAppear {
                            // Scroll to the last message when the view appears
                            DispatchQueue.main.async {
                                proxy.scrollTo(messagesManager.lastMessageId ?? "", anchor: .bottom)
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
                .background(Color("middleColor"))
                
                MessageField(user: user.id, chatid: vm.createChatRoomId(secndUserId: user.id))
            }
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
        }
        .gesture(DragGesture().onEnded({ gesture in
            if gesture.translation.width > 100  {
                self.dismiss.callAsFunction()
            }
        }))
    }
}
