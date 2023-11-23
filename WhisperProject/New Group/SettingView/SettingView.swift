//
//  SettingView.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import SwiftUI
import Firebase
class SettinsViewModel : ObservableObject {
    
    @Published var userList = [UserModel]()

    func getUserData() {
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

            var friendsList = [UserModel]()
            var currentUser: UserModel?

            for document in snapshot.documents {
                let id = document.documentID
                let name = document["name"] as? String ?? "name"
                let phone = document["phone"] as? String ?? "phone"
                let profilePhoto = document["profilePhoto"] as? String ?? "profilePhoto"
                let status = document["status"] as? String ?? "status"

                if id == FirestoreManager.shared.getCurrentUserID() {
                    currentUser = UserModel(id: id, name: name, phone: phone, profilePhoto: profilePhoto, status: status)
                }
            }

            DispatchQueue.main.async {
                if let currentUser = currentUser {
                    self.userList = [currentUser]
                }
            }
        }
    }
    
}


struct SettingView: View {
    @ObservedObject var vm = SettinsViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SettingView()
}
