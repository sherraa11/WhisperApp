//
//  HomeViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 25/12/2023.
//

import Foundation
import Firebase

class HomeViewModel : ObservableObject {
    @Published var allPost : [PostsModel]?
    
    
    
    init(){
        getAllPost()
        setupPostlistenr()
    }
    
    func getAllPost(){
        FirestoreManager.shared.getPostsData { Posts in
            if let posts = Posts  {
                let sortedPosts = posts.sorted { $0.timestamp > $1.timestamp }
                DispatchQueue.main.async {
                    self.allPost = sortedPosts
                }
            }
        }
    }
    func setupPostlistenr() {
            let chatroomsCollectionRef = Firestore.firestore().collection("posts")
            // Add a snapshot listener to the chatrooms collection
            chatroomsCollectionRef.addSnapshotListener { [weak self] querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching chatrooms: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if !snapshot.documentChanges.isEmpty {
                    // When changes occur, update the friendList
                    self?.getAllPost()
                }
            }
        }

}
