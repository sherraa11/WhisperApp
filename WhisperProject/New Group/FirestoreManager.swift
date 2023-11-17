//
//  FirestoreManager.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import Foundation
import Firebase

final class FirestoreManager {
    static let shared = FirestoreManager()
    private init(){ }
    
    func CheckUser(completion : @escaping (Bool , String)-> Void){
        let db = Firestore.firestore()
        db.collection("friends").getDocuments { snap, error in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            for i in snap!.documents{
                if i.documentID == Auth.auth().currentUser?.uid{
                    completion(true , i.get("name") as! String)
                    return
                 }
            }
            completion(false , "")
        }
    }
}
