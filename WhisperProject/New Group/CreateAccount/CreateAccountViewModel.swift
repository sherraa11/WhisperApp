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
    @Published var status : String = ""
    @Published var showHome : Bool = UserDefaults.standard.value(forKey: "showHome") as? Bool ?? false
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
    
    func uploadImage() -> Bool{
        guard let selectedImage else {
            print("select an image")
            return false
        }
        StorageManager.shared.uploadPhoto(selectedImage: selectedImage)
        return true
    }
    
    func createUser() -> Bool{
        print(name)
        print(status)
        if name != "" &&  status != "" {
            FirestoreManager.shared.createUser(name: name, status: status)
            return true
        }
        return false
    }
    
    func CreataAndUpload() {
        if createUser() && uploadImage() {
            showHome.toggle()
            UserDefaults.standard.set( true, forKey: "showHome")
            print(showHome)
        }
    }
    
}
