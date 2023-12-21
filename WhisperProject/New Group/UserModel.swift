//
//  FriendsModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 17/11/2023.
//

import Foundation
struct UserModel : Identifiable , Hashable {
    let id : String
    let name : String
    let phone : String
    let profilePhoto : String
    let status : String
    let username: String
}
