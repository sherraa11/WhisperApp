//
//  CreateAccountViewModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//

import Foundation
import SwiftUI
import PhotosUI

class CreateAccountViewModel : ObservableObject {
    @Published var name : String = ""
    @Published var username : String = ""
    @Published var status : String = ""
    @Published var showNameError : Bool = false
    @Published var showUserNameError : Bool = false
    @Published var showStatusError : Bool = false
    @Published var showImageError : Bool = false
    @Published var showHome : Bool = false
    @Published private(set) var selectedImage : UIImage? = nil
    @Published var imageSelection : PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
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
    
    func CreateUser() {
        if username.isEmpty {
            showUserNameError = true
        } else {
            showUserNameError = false
        }
        if selectedImage == nil {
            showImageError = true
        } else {
            showImageError = false
        }
        if name.isEmpty {
            showNameError = true
        } else {
            showNameError = false
        }
        if status.isEmpty {
            showStatusError = true
        } else {
            showStatusError = false
        }
        if !showImageError && !showNameError && !showStatusError {
            
            FirestoreManager.shared.createUser(name: name, status: status)
            StorageManager.shared.uploadPhoto(selectedImage: selectedImage!)
            showHome.toggle()
        }
    }
}


