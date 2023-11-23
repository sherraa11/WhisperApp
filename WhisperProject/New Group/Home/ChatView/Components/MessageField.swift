//
//  MessageField.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI



struct MessageField: View {
    @ObservedObject var vm = ChatViewModel()
    @State var user : String
    @State var chatid : String
    @State var messageText: String = "" // Store the message locally

    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("Enter your message here"), text: $messageText)
                .frame(height: 52)
                .disableAutocorrection(true)
            Button {
                vm.sendMessage(Message: messageText, chatId: chatid, senderId: user)
                messageText = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("middleColor"))
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("bcolor"))
        .cornerRadius(50)
        .padding()
    }
}



struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
