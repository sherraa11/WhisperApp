//
//  HomeViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//

import Foundation
import Firebase

class HomeViewModel : ObservableObject {
    @Published var allUserList = [UserModel]()
    @Published var friendList = [CombinedUserModel]()
    @Published var searchText : String = ""
    @Published var isLoading : Bool = true

    init(){
        getAllUsers()
        getFriendsList()
        setupChatroomListener()
    }
//    check if user searching
    func isSearching()  -> Bool {
        if searchText.isEmpty {
            return false
        }else {
            return true
        }
    }

//    filter data based on user search (phone , name)
    var filteredFriends: [UserModel] {
        guard !searchText.isEmpty else { return allUserList }
        return allUserList.filter { friend in
            return friend.phone.localizedCaseInsensitiveContains(searchText) ||
                   friend.name.localizedCaseInsensitiveContains(searchText)
        }
    }
//    get all users with chat to view at home
    func getFriendsList() {
        FirestoreManager.shared.getCombinedUserModel { returnedCombinedUsers in
            let sortedCombinedUsers = returnedCombinedUsers.sorted { $0.userHomeModel.lastMessageTimestamp > $1.userHomeModel.lastMessageTimestamp }
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
  
// i wanted to perform a better search experience but it should make the search from firebase
    func getAllUsers() {
        FirestoreManager.shared.getData { Allusers in
            if Allusers != nil {
                DispatchQueue.main.async {
                    self.allUserList = Allusers!
                }
            }
        }
    }
}
