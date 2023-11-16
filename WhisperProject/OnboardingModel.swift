//
//  OnboardingModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 16/11/2023.
//

import Foundation
import SwiftUI
enum OnboardingModel {
    case First , Second , Third
    
    var header : String {
        switch self {
        case.First :
            return "Hello !"
        case.Second :
            return "Features"
        case.Third :
            return "Let's setup"
        }
    }
    
    var body : String {
        switch self {
        case.First:
            return """
                     Welcome to Whisper! Connect and chat with ease.
                    Ready to start chatting? Let's get you set up!
                    """
        case.Second:
            return """
                     Send and receive messages in real-time.
                     Chat with friends anytime, anywhere.
                     """
        case.Third:
            return "Tap 'Start' to begin your first conversation"
        }
    }
    
    var icon: Image {
        switch self {
        case.First:
            return Image(.icon1)
        case.Second:
            return Image(.icon2)
        case.Third:
            return Image(.icon3)
        }
    }
}
