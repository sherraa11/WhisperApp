//
//  ChatViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 19/11/2023.
//

import Foundation

class ChatViewModel : ObservableObject {
    
    @Published var message : String = ""
    @Published var showTime = false
    @Published var userID : String = ""
    
    init(){}
    
    func createChatRoomId(secndUserId : String) -> String  {
        let chatId = FirestoreManager.shared.createChatRoomID(secondUser: secndUserId)
        return chatId
    }
    
    func sendMessage(Message: String , chatId : String , senderId : String) {
        print(chatId)
        if Message != ""{
            MessagesManager.shared.sendMessage(text: Message, chatId:chatId , senderId: FirestoreManager.shared.getCurrentUserID() )
            
        }
    }
}
