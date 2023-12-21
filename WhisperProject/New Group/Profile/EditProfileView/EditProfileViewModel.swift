//
//  EditProfileViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/12/2023.
//

import Foundation
import PhotosUI
import SwiftUI


class EditProfileViewModel: ObservableObject {
    @Published var updatedFullName: String = ""
    @Published var updatedUserName: String = ""
    @Published var updatedStatus: String = ""
    @Published var showNameError : Bool = false
    @Published var showStatusError : Bool = false
    @Published var showUsernameError : Bool = false
    @Published var isLoading : Bool = false
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
    @Published private(set) var selectedImage : UIImage? = nil
    @Published var imageSelection : PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    init(){
        getCurrentUserInfo()
    }
    private func setImage(from selection :PhotosPickerItem? ) {
        guard let selection else {return}
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self){
                if let uiImage = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.selectedImage = uiImage
                    }
                    return
                }
            }
        }
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
    func checkUser(completion: @escaping (Bool) -> Void) {
        let showNameError = updatedFullName.isEmpty
        let showUsernameError = updatedUserName.isEmpty
        let showStatusError = updatedStatus.isEmpty
        
        // Set error flags based on conditions
        self.showNameError = showNameError
        self.showUsernameError = showUsernameError
        self.showStatusError = showStatusError
        
        if !showUsernameError && !showNameError && !showStatusError {
            isLoading = true // Set loading state before Firestore update
            
            FirestoreManager.shared.updateCurrentUser(name: updatedFullName, userName: updatedUserName, status: updatedStatus) { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error updating user data: \(error.localizedDescription)")
                    completion(false)
                    self.isLoading = false // Reset loading state after Firestore update failure
                } else {
                    if let selectedImage = self.selectedImage {
                        StorageManager.shared.uploadPhoto(selectedImage: selectedImage) { result in
                            switch result {
                            case .success:
                                completion(true)
                            case .failure(let photoUploadError):
                                print("Error uploading photo: \(photoUploadError.localizedDescription)")
                                completion(false)
                            }
                            
                            self.isLoading = false // Reset loading state after photo upload completion or failure
                        }
                    } else {
                        completion(true)
                        self.isLoading = false // Reset loading state after Firestore update success (no image upload)
                    }
                }
            }
        } else {
            completion(false) // Handle the case where there are validation errors
        }
    }
}
