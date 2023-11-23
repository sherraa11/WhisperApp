//
//  MessageModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import Foundation
struct MessageModel: Identifiable, Hashable, Decodable {
    var id : String
    var message: String
    var senderId: String
    var timestamp: Date
}

/*
 message
 senderID
 timestamp
 */
