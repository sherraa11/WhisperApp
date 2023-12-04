//
//  CombinedUserModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 03/12/2023.
//

import Foundation
struct CombinedUserModel : Identifiable{
    let id : String
    let userHomeModel: UserHomeModel
    let userModel: UserModel
}
