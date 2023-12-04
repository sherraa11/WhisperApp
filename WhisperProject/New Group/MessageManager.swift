//
//  MessageManager.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class MessagesManager: ObservableObject {
    static let shared = MessagesManager()
    @Published private(set) var messages: [MessageModel] = []
    @Published var lastMessageId: String?
    
    // Create an instance of our Firestore database
    let db = Firestore.firestore()
    init() {}
    // Read message from Firestore in real-time with the addSnapShotListener
    func getMessages(chatId : String) {
        db.collection("chatrooms").document(chatId).collection("chats").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            // Mapping through the documents
            self.messages = documents.compactMap { document -> MessageModel? in
                do {
                    // Converting each document into the Message model
                    return try document.data(as: MessageModel.self)
                } catch {
                    print("Error decoding document into Message: \(error)")
                    return nil
                }
            }
            // Sorting the messages by sent date
            self.messages.sort { $0.timestamp < $1.timestamp }
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
            //save last Message details
            if let lastMessage = self.messages.last {
                self.db.collection("chatrooms").document(chatId).setData(["lastMessageTimestamp" : lastMessage.timestamp , "lastMessageSenderId" : lastMessage.senderId ,"lastMessage" : lastMessage.message], merge: true)
            }
        }
    }
    // Add a message in Firestore
    func sendMessage(text: String, chatId: String, senderId: String) {
        let db = Firestore.firestore()
        db.collection("chatrooms").document(chatId).collection("chats").addDocument(data: [
            "message": text,
            "senderId": senderId,
            "timestamp": Date(),
            "id":UUID().uuidString
        ]) { error in
            if let error = error {
                print("Error saving message: \(error.localizedDescription)")
                return
            }
        }
    }
   

}
