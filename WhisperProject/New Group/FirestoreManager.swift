//
//  FirestoreManager.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirestoreManager {
    static let shared = FirestoreManager()
    let db = Firestore.firestore()
    private init(){ }
    
    func currentUser() -> String {
        if Auth.auth().currentUser != nil {
            let uid = Auth.auth().currentUser!.uid
            return uid
        }
        return "didnt get the uid"
    } 
    
    func currentUserPhone() -> String {
        if Auth.auth().currentUser != nil {
            if let phone = Auth.auth().currentUser!.phoneNumber {
                let phoneNumber = phone
                return phoneNumber
            }
        }
        return "didnt get the phoneNumber"
    }
    
    
    func createUser(name: String , status : String){
        db.collection("friends").document(currentUser()).setData(["name" : name , "status" : status , "phone" : currentUserPhone()]) { error in
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
            print("userCreated")
        }
    }

    func CheckUser(completion : @escaping (Bool )-> Void){
        let db = Firestore.firestore()
        db.collection("friends").getDocuments { snap, error in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            for i in snap!.documents{
                if i.documentID == Auth.auth().currentUser?.uid{
                    completion(true)
                    UserDefaults.standard.setValue(true, forKey: "showHome")
                    return
                 }
            }
            completion(false)
        }
    }
}
