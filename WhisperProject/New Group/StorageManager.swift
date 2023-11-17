//
//  StorageManager.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//
import SwiftUI
import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift


class StorageManager {
    static let shared = StorageManager()
    private init(){ }
    
    func uploadPhoto (selectedImage : UIImage){
        let storage = Storage.storage().reference()
        let imageData = selectedImage.jpegData(compressionQuality: 1)
        let path = FirestoreManager.shared.currentUser()
        let file = storage.child(path)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        file.putData(imageData!, metadata: metaData) { metadata, error in
            if error != nil {
                print(error?.localizedDescription ?? "error uploading task")
            }
            file.downloadURL { url, error in
                if error != nil {
                    print(error?.localizedDescription ?? "didnt get the image url from the storage" )
                }
                guard let urlString = url?.absoluteString else { return }
                let db = Firestore.firestore()
                db.collection("friends").document(path).setData(["profilePhoto": urlString ] , merge: true) { error in
                    if error != nil{
                        print((error?.localizedDescription)!)
                        return
                    }
                }
            }
        }
    }
}
