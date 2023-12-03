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
    @Published var friendList = [UserModel]()
    @Published var searchText : String = ""

    init(){
        getAllUsers()
        getFriendsList()
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
    func getFriendsList(){
        let chatroomsCollectionRef = Firestore.firestore().collection("chatrooms")
        // Add a snapshot listener to the chatrooms collection
        chatroomsCollectionRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching chatrooms: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if !snapshot.documentChanges.isEmpty {
                FirestoreManager.shared.getUserFriendsList { returnedFriendList in
                    self.friendList = returnedFriendList
                }
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
