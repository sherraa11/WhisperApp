//
//  PostsModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 21/12/2023.
//

import Foundation
struct PostsModel: Identifiable {
    let id : String
    let caption : String
    let postPhoto : String
    let timestamp : Date
    let userWhoCreateThePost: UserModel
}
