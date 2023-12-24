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
    
    /*
     this function it upload an image from the liberary to firebase Storage
     and make a downloadd url to its userdata as string 
     */
    
    func uploadPhoto(selectedImage: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let storage = Storage.storage().reference()
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "com.yourapp.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }

        let path = FirestoreManager.shared.getCurrentUserID()
        let file = storage.child(path)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"

        file.putData(imageData, metadata: metaData) { metadata, error in
            if let uploadError = error {
                completion(.failure(uploadError))
                print("Error uploading image: \(uploadError.localizedDescription)")
            } else {
                file.downloadURL { url, downloadError in
                    if let downloadError = downloadError {
                        completion(.failure(downloadError))
                        print("Error getting download URL: \(downloadError.localizedDescription)")
                    } else if let urlString = url?.absoluteString {
                        let db = Firestore.firestore()
                        db.collection("friends").document(path).setData(["profilePhoto": urlString], merge: true) { firestoreError in
                            if let firestoreError = firestoreError {
                                completion(.failure(firestoreError))
                                print("Error updating Firestore document: \(firestoreError.localizedDescription)")
                            } else {
                                completion(.success(urlString))
                            }
                        }
                    }
                }
            }
        }
    }
    
    func uploadPost(selectedImage: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let storage = Storage.storage().reference()
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "com.yourapp.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }

        let path = UUID().uuidString
        let file = storage.child(path)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"

        file.putData(imageData, metadata: metaData) { metadata, error in
            if let uploadError = error {
                completion(.failure(uploadError))
                print("Error uploading image: \(uploadError.localizedDescription)")
            } else {
                file.downloadURL { url, downloadError in
                    if let downloadError = downloadError {
                        completion(.failure(downloadError))
                        print("Error getting download URL: \(downloadError.localizedDescription)")
                    } else if let urlString = url?.absoluteString {
                        completion(.success(urlString))
                    }
                }
            }
        }
    }


}
