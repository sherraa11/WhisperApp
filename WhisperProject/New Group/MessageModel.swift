//
//  MessageModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 18/11/2023.
//

import Foundation
struct MessageModel: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
