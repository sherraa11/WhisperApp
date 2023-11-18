//
//  HomeViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//

import Foundation
import Firebase

class HomeViewModel : ObservableObject {
    @Published var FriendsList = [FriendsModel]()
//    @Published var FilteredList = [FriendsModel]()
    @Published var searchText : String = ""
   
    init(){
        getData()
    }
    func isSearching()  -> Bool {
        if searchText.isEmpty {
            return false
        }else {
//            fileted(searchText: searchText)
            return true
        }
    }
    
    var filteredFriends: [FriendsModel] {
        guard !searchText.isEmpty else { return FriendsList }
        
        return FriendsList.filter { friend in
            return friend.phone.localizedCaseInsensitiveContains(searchText) ||
                   friend.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    
//    func fileted(searchText: String){
//        guard !searchText.isEmpty else {
//            FilteredList = []
//            return
//        }
//        let search = searchText.lowercased()
//        FilteredList = FriendsList.filter({ friends in
//            let nameSearch = friends.name.lowercased().contains(search)
//            let numberSearch = friends.phone.lowercased().contains(search)
//            return nameSearch || numberSearch
//        })
//        
//        
//    }
    
    
    func getData() {
        let db = Firestore.firestore()
        db.collection("friends").getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }

            guard let snapshot = snapshot else {
                print("Snapshot is nil.")
                return
            }

            var friendsList = [FriendsModel]()

            for document in snapshot.documents {
                let id = document.documentID
                let name = document["name"] as? String ?? "name"
                let phone = document["phone"] as? String ?? "phone"
                let profilePhoto = document["profilePhoto"] as? String ?? "profilePhoto"
                let status = document["status"] as? String ?? "status"

                if id == FirestoreManager.shared.currentUser() {
                
                } else {
                    let friend = FriendsModel(id: id, name: name, phone: phone, profilePhoto: profilePhoto, status: status)
                    friendsList.append(friend)
                }
            }

            DispatchQueue.main.async {
                self.FriendsList = friendsList
            }
        }
    }
}
