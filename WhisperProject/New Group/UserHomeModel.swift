//
//  ChatroomModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 20/11/2023.
//

import Foundation
struct UserHomeModel : Hashable, Decodable {
    let chatRoomId : String
    let lastMessage : String
    let lastMessageSenderId : String
    let lastMessageTimestamp : Date
    let userIds : [String]
}
