//
//  ChatroomModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 20/11/2023.
//

import Foundation
struct LastMessageDeatils : Hashable, Decodable {
    let lastMessage : String
    let lastMessageSenderId : String
    let lastMessageTimestamp : Date
}
