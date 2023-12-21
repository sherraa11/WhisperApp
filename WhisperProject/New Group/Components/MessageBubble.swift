//
//  MessageBubble.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI

struct MessageBubble: View {
    @ObservedObject var vm = MessagingViewModel()
    let currentUser = FirestoreManager.shared.getCurrentUserID()
    var message: MessageModel
    
    var body: some View {
        VStack(alignment: message.senderId != currentUser ? .leading : .trailing) {
            HStack {
                Text(message.message)
                    .font(.custom("Poppins", size: 16))
                    .fontWeight(.medium)
                    .padding()
                    .background(message.senderId != currentUser ? Color(.textFieldbackground) : Color(.terqwaz))
                    .foregroundStyle(message.senderId != currentUser ? .black : .white)
                    .cornerRadius(25, corners:message.senderId != currentUser ? [.bottomRight ,.topRight] : [.topLeft, .bottomLeft])
            }
            .frame(maxWidth: 300, alignment: message.senderId != currentUser ? .leading : .trailing)
            .onTapGesture {
                vm.showTime.toggle()
            }
            
            if vm.showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.senderId != currentUser ? .leading : .trailing, 25)
            }
        }.cornerRadius(25, corners: [.topLeft,.topRight])
        .frame(maxWidth: .infinity, alignment: message.senderId != currentUser ? .leading : .trailing)
        .padding(message.senderId != currentUser ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

#Preview {
    MessageBubble(message: MessageModel(id: "", message: "hello", senderId: "FirestoreManager.shared.getCurrentUserID()", timestamp: .now))
}
