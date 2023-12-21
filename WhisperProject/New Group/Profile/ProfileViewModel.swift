//
//  ProfileViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 06/12/2023.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var showEditProfile : Bool = false
    @Published var shouldRefreshData : Bool = false
    @Published var updatedFullName: String = ""
    @Published var updatedUserName: String = ""
    @Published var updatedStatus: String = ""
    @Published var photoURL : URL?
    @Published var currentUserData: UserModel? {
        didSet {
            // Set initial values when currentUserData is set
            if let currentUserData = currentUserData {
                DispatchQueue.main.async {
                    self.updatedFullName = currentUserData.name
                    self.updatedUserName = currentUserData.username
                    self.updatedStatus = currentUserData.status
                }
            }
        }
    }
    init(){
        getCurrentUserInfo()
    }
    func getCurrentUserInfo() {
        FirestoreManager.shared.getCurrentUserData { returnedUser in
            if let returnedUser = returnedUser {
                DispatchQueue.main.async {
                    self.currentUserData = returnedUser
                    self.photoURL = URL(string: returnedUser.profilePhoto)
                }
            }
        }
    }
}
