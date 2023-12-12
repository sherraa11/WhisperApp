//
//  ProfileViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 06/12/2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var currentUser: UserModel?
    @Published var showEditProfile : Bool = false
    init() {
        currentUser = UserModel(id: "", name: "shera", phone: "01092772040", profilePhoto: "https://firebasestorage.googleapis.com:443/v0/b/chatapp-9879e.appspot.com/o/xQp3ndOUsQTuCyyX3iQQWHO82Cw1?alt=media&token=718bf964-1dc3-4145-928f-a0ffbc15c383", status: "احا ")
//        getCurrentUserInfo()
    }
    
    func getCurrentUserInfo() {
        FirestoreManager.shared.getCurrentUserData { returnedUser in
            if let returnedUser = returnedUser {
                DispatchQueue.main.async {
                    self.currentUser = returnedUser
                }
            }
        }
    }
}
