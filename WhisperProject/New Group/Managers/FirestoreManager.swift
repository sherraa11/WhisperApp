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
    
    /*
     this function will get the currend user id
     maybe it should be in AuthentecationManager
     */
    func getCurrentUserID() -> String {
        if Auth.auth().currentUser != nil {
            let uid = Auth.auth().currentUser!.uid
            return uid
        }
        return "didnt get the uid"
    }
    /*
     this function will get the currend user phoneNumber
     maybe it should be in AuthentecationManager too
     */
    func getCurrentUserPhoneNumber() -> String {
        if Auth.auth().currentUser != nil {
            if let phone = Auth.auth().currentUser!.phoneNumber {
                let phoneNumber = phone
                return phoneNumber
            }
        }
        return "didnt get the phoneNumber"
    }
    /*
     this function create a user in firebase collectoin as UserModel uid ,name , status , phone
     */
    func createUser(name: String , status : String , username: String){
        db.collection("friends").document(getCurrentUserID()).setData(["name" : name , "status" : status ,"id" : getCurrentUserID(), "phone" : getCurrentUserPhoneNumber(), "username": username]) { error in
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
        }
    }
    /*
     Check user if he sign up before by comparing every uesr uid with
     the current user id if ture it will chagne a userDefaults value "showHome" to true
     so when the application cloesd and open again it will check the user defaults to open home or not
     */
    func checkUserIfExists(completion : @escaping (Bool )-> Void){
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
    //    it create a unique id from 2 user IDs an create it in firebase firestore collection name "chatrooms" and save the 2 users ids
    func createChatRoomID(secondUser: String) -> String {
        let currentUser = FirestoreManager.shared.getCurrentUserID()
        let sortedUserIds = [currentUser, secondUser].sorted()
        let chatId = sortedUserIds.joined(separator: "_")
        db.collection("chatrooms").document(chatId).setData(["chatRoomId" : chatId, "userIds" : [currentUser , secondUser]] , merge: true) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
        return chatId
    }
    /*
     this function used to search with current user id in firebase collection "chatrooms"
     and if the user exisit , it will get back the chat document and lastMessage etc ...
     */
    func getAllFriendUserModel(completion: @escaping ([UserHomeModel]) -> Void) {
        let currentUserID = getCurrentUserID()
        db.collection("chatrooms")
            .whereField("userIds", arrayContains: currentUserID)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting chat rooms: \(error.localizedDescription)")
                    completion([])
                } else {
                    var chatUsersModels: [UserHomeModel] = []
                    for document in querySnapshot!.documents {
                        if let chatRoomId = document["chatRoomId"] as? String,
                           let lastMessage = document["lastMessage"] as? String,
                           let lastMessageSenderId = document["lastMessageSenderId"] as? String,
                           let lastMessageTimestamp = document["lastMessageTimestamp"] as? Timestamp,
                           let userIds = document["userIds"] as? [String] {
                            let userHomeModel = UserHomeModel(chatRoomId: chatRoomId,
                                                              lastMessage: lastMessage,
                                                              lastMessageSenderId: lastMessageSenderId,
                                                              lastMessageTimestamp: lastMessageTimestamp.dateValue(),
                                                              userIds: userIds)
                            chatUsersModels.append(userHomeModel)
                        }
                    }
                    completion(chatUsersModels)
                }
            }
        }
    /*
     this function use the returned CombinedUserModel of UserModel and UserHomeModel to handle the home view and the chat person data
     */
    func getCombinedUserModel(completion: @escaping ([CombinedUserModel]) -> Void) {
        getAllFriendUserModel { userHomeModels in
            var combinedUsers: [CombinedUserModel] = []
            var userModelList: [UserModel] = [] // Collect UserModels
            let dispatchGroup = DispatchGroup()
            for userHomeModel in userHomeModels {
                dispatchGroup.enter()
                let otherUserID = userHomeModel.userIds.first(where: { $0 != self.getCurrentUserID() }) ?? self.getCurrentUserID()
                self.db.collection("friends").document(otherUserID).getDocument { (document, error) in
                    defer {
                        dispatchGroup.leave()
                    }
                    if let error = error {
                        print("Error getting user: \(error.localizedDescription)")
                        return
                    }
                    guard let document = document, document.exists,
                          let name = document["name"] as? String,
                          let phone = document["phone"] as? String,
                          let profilePhoto = document["profilePhoto"] as? String,
                          let username = document["username"] as? String ,
                          let status = document["status"] as? String else {
                        return
                    }
                    let userModel = UserModel(id: otherUserID, name: self.getCurrentUserID() == otherUserID ? "Me (You)" : name, phone: phone, profilePhoto: profilePhoto, status: status, username: username)
                    // Append the UserModel to the list
                    userModelList.append(userModel)
                    let combinedUser = CombinedUserModel(id: UUID().uuidString, userHomeModel: userHomeModel, userModel: userModel)
                    combinedUsers.append(combinedUser)
                }
            }
            dispatchGroup.notify(queue: .main) {
                // All asynchronous tasks completed
                // Return the combinedUsers list
                completion(combinedUsers)
            }
        }
    }
    //    get all data from firebase to perform a better search [weak self] helps prevent a strong reference cycle(retain cycles)
    func getData(completion: @escaping ([UserModel]?) -> Void) {
        db.collection("friends").getDocuments {[weak self] snapshot, error in
            guard let _ = self else { return }
            if let _ = error {
                completion(nil)
                return
            }
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }
            var friendsList = [UserModel]()
            for document in snapshot.documents {
                let id = document.documentID
                let name = document["name"] as? String ?? "name"
                let phone = document["phone"] as? String ?? "phone"
                let profilePhoto = document["profilePhoto"] as? String ?? "profilePhoto"
                let status = document["status"] as? String ?? "status"
                let username = document["username"] as? String ?? " username "
                if id == FirestoreManager.shared.getCurrentUserID() {
                    let me = UserModel(id: id, name: "Me (You)", phone: phone, profilePhoto: profilePhoto, status: status, username: username)
                    friendsList.append(me)
                } else {
                    let friend = UserModel(id: id, name: name, phone: phone, profilePhoto: profilePhoto, status: status, username: username)
                    friendsList.append(friend)
                }
            }
            completion(friendsList)
        }
    }
    
    func getCurrentUserData(completion: @escaping (UserModel?) -> Void) {
         let currentUserID = FirestoreManager.shared.getCurrentUserID()
        db.collection("friends").document(currentUserID).getDocument { document, error in
            if let error = error {
                print("Error getting document: \(error)")
                completion(nil)
                return
            }
            
            var currentUser: UserModel?
            if let document = document, document.exists {
                let id = document.documentID
                let name = document["name"] as? String ?? "name"
                let phone = document["phone"] as? String ?? "phone"
                let profilePhoto = document["profilePhoto"] as? String ?? "profilePhoto"
                let status = document["status"] as? String ?? "status"
                let username = document["username"] as? String ?? " username "
                
                currentUser = UserModel(id: id, name: name, phone: phone, profilePhoto: profilePhoto, status: status, username: username)
            }
            
            completion(currentUser)
        }
    }
    func updateCurrentUser(name: String? = nil, userName: String? = nil, status: String? = nil, completion: @escaping (Error?) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated."]))
            return
        }

        var updateData: [String: Any] = [:]

        if let newName = name {
            updateData["name"] = newName
        }
        if let newUserName = userName {
            updateData["username"] = newUserName
        }
        if let newStatus = status {
            updateData["status"] = newStatus
        }

        db.collection("friends").document(currentUserID).updateData(updateData) { error in
            if let error = error {
                print("Error updating user data: \(error.localizedDescription)")
            }
            completion(error)
        }
    }




}
