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
    
    @State var imageUrl: URL
    @State var name: String
    @State var friendUserID: String
    @State var chatid: String?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    TitleRow(imageUrl: imageUrl, name: name)
                    
                    ScrollViewReader { proxy in
                        ScrollView {
                            ForEach(messagesManager.messages, id: \.id) { message in
                                MessageBubble(message: message)
                            }
                        }
                        .padding(.top, 10)
                        .background(.white)
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                        .onChange(of:messagesManager.lastMessageId , { old, new in
                            withAnimation {
                                proxy.scrollTo(new, anchor: .bottom)
                            }
                        })
                    }
                }.background(Color("middleColor"))
                MessageField(user: friendUserID, chatid: vm.createChatRoomId(secndUserId: friendUserID))
            }
            .onAppear {
                messagesManager.lastMessageId = messagesManager.lastMessageId
                chatid = vm.createChatRoomId(secndUserId: friendUserID)
                guard let chatid else {return}
                messagesManager.getMessages(chatId: chatid)
            }
            .toolbar(.hidden)
        }.gesture(DragGesture().onEnded({ gesture in
            if gesture.translation.width > 100  {
                self.dismiss.callAsFunction()
            }
        }))
    }
}
