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
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    TitleRow(user: user)
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
                            DispatchQueue.main.async {
                                proxy.scrollTo(messagesManager.lastMessageId ?? "", anchor: .bottom)
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
                
                
                MessageField(user: user.id, chatid: vm.createChatRoomId(secndUserId: user.id))
            }
            .toolbar(.hidden)
            .onAppear {
                chatid = vm.createChatRoomId(secndUserId: user.id)
                guard let chatid = chatid else { return }
                messagesManager.getMessages(chatId: chatid)
                
                // Set lastMessageId to the ID of the last message in the chat here
                if let lastMessageId = messagesManager.messages.last?.id {
                    messagesManager.lastMessageId = lastMessageId
                }
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


#Preview {
    MessageingView( user: UserModel(id: UUID().uuidString, name: "Ahmed", phone: "aa@Ahmed110", profilePhoto: "https://firebasestorage.googleapis.com/v0/b/chatapp-9879e.appspot.com/o/00ea6c28-d491-4920-af03-b64c5a59ffa9?alt=media&token=778f00f5-92c6-492c-bc28-0fe0b620ca31"
                                    , status: "ggs",username: "dfsfdfs"))
}
