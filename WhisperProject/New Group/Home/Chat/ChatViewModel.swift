//
//  HomeViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//

import Foundation
import Firebase

class ChatViewModel : ObservableObject {
    @Published var friendList = [CombinedUserModel]()
    @Published var isLoading : Bool = true
    @Published var selectedFriend : CombinedUserModel?
    

    init(){

        getFriendsList()
   setupChatroomListener()
              
    }

//    get all users with chat to view at home
    func getFriendsList() {
        FirestoreManager.shared.getCombinedUserModel { returnedCombinedUsers in
            let sortedCombinedUsers = returnedCombinedUsers.sorted { $0.userHomeModel.lastMessageTimestamp > $1.userHomeModel.lastMessageTimestamp
            }
            
            self.friendList = sortedCombinedUsers
            self.isLoading = sortedCombinedUsers.isEmpty
        
           }
       }
 
    func setupChatroomListener() {
            let chatroomsCollectionRef = Firestore.firestore().collection("chatrooms")
            // Add a snapshot listener to the chatrooms collection
            chatroomsCollectionRef.addSnapshotListener { [weak self] querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching chatrooms: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if !snapshot.documentChanges.isEmpty {
                    // When changes occur, update the friendList
                    self?.getFriendsList()
                }
            }
        }
}
